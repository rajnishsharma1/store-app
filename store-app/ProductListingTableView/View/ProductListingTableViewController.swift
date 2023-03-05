//
//  ProductListingTableViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingTableViewController: UIViewController , NetworkDelegate {
    
    //MARK: - Properties
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    private var masterStoreItems: [ItemModel] = []
    
    private var viewModel: StoreViewModel = StoreViewModel()
    
    //MARK: - UI Elements
    private var myTableView: UITableView!
    private var loader: LoaderView = LoaderView()
    private var error: ErrorViewController = ErrorViewController()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let slider: UISlider = UISlider()
    private let sliderLabel: UILabel = UILabel()
    
    var searchDelegate: UISearchBarDelegate!
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        view.backgroundColor = .white
        
        /// Setting network delegate
        viewModel.networkDelegate = self
        
        /// Fetching data from Api
        fetchData()
        
        /// Setting up layouts
        setupTableView()
        
        /// Setting up pull to request
        setupPullToRefresh()
    }
    
    // MARK: - Setup Slider
    /// Setup Slider
    private func setupSlider() {
        let maxValue = storeItems.count
        let minValue: Float = 0
        
        slider.minimumValue = minValue
        slider.maximumValue = Float(maxValue)
        slider.value = Float(maxValue)
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        
        sliderLabel.text = String(storeItems.count)
        sliderLabel.textColor = .black
    }
    
    // MARK: - Slide value change listener
    @objc func sliderValueDidChange(sender: UISlider) {
        storeItems = masterStoreItems
        
        setSliderValue(value: sender.value)
        
        storeItems = Array(storeItems.prefix(upTo: Int(sender.value)))
        
        myTableView.reloadData()
    }
    
    // MARK: - Set Slider Value
    /// Setting slider value
    private func setSliderValue(value: Float) {
        slider.setValue(value, animated: false)
        sliderLabel.text = String(Int(value))
    }
    
    // MARK: - Pull to refresh callback
    /// Pull to refresh callback listener
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
    }
    
    // MARK: - Constraints for Slider
    // Add Constraints for the Slider
    private func addSliderConstraint() {
         slider.translatesAutoresizingMaskIntoConstraints = false
         
         let sliderTop = NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: myTableView, attribute: .bottom, multiplier: 1, constant: 10)
         let sliderBottom = NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
         let sliderLeading = NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
         
         self.view.addConstraints([sliderTop, sliderBottom, sliderLeading])
     }
    
    // MARK: - Constraints for SliderLabel
    // Add Constraints for the SliderLabel
    private func addSliderLabelConstraint() {
         sliderLabel.translatesAutoresizingMaskIntoConstraints = false
         
         let sliderLabelTop = NSLayoutConstraint(item: sliderLabel, attribute: .top, relatedBy: .equal, toItem: myTableView, attribute: .bottom, multiplier: 1, constant: 10)
         let sliderLabelBottom = NSLayoutConstraint(item: sliderLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
         let sliderLabelLeading = NSLayoutConstraint(item: sliderLabel, attribute: .leading, relatedBy: .equal, toItem: slider, attribute: .trailing, multiplier: 1, constant: 20)
         let sliderLabelTrailing = NSLayoutConstraint(item: sliderLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
         
         self.view.addConstraints([sliderLabelTop, sliderLabelBottom, sliderLabelLeading, sliderLabelTrailing])
     }
    
    // MARK: - Constraints for the TableView
    // Add Constraints for the TableView
    private func addTableViewConstraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableTop = NSLayoutConstraint(item: myTableView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150)
        let tableWidth = NSLayoutConstraint(item: myTableView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([tableTop, tableWidth])
    }
    
    // MARK: Pull To Refresh Setup
    /// Pull to request setup
    private func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        myTableView.addSubview(refreshControl)
    }
    
    // MARK: - Fetch Data from ViewModel
    /// Fetch data from ViewModel
    private func fetchData() {
        Task {
            await viewModel.getStoreDetails()
        }
    }
    
    // MARK: - Update changes
    /// Update changes for ViewModel
    func updateChanges(result: DataWrapper<StoreData>) {
        if (result.isLoading == true) {
            setupLoader()
        } else if (result.response != nil) {
            setupPostResponseScreen(result: result)
        } else if (result.error != nil) {
            setupErrorScreen(result: result)
        }
    }
    
    // MARK: - Setup Loader
    /// Setting up loader
    ///
    /// This will happen when API Call is happening
    private func setupLoader() {
        Task {
            if (!self.refreshControl.isRefreshing) {
                self.loader.showLoader(view: self.view)
            }
            self.error.view.removeFromSuperview()
        }
    }
    
    // MARK: - Post response setup
    /// Post response
    ///
    /// This will happen when API call is successful and
    /// viewModel has some data to feed to view
    private func setupPostResponseScreen(result: DataWrapper<StoreData>) {
        guard let response = result.response else {return}

        Task {
            self.masterStoreItems = response.items
            self.storeItems = response.items
            self.view.addSubview(self.myTableView)
            self.view.addSubview(self.slider)
            self.view.addSubview(self.sliderLabel)
            
            self.addTableViewConstraints()
            self.addSliderConstraint()
            self.addSliderLabelConstraint()
            self.setupSlider()
            
            // Reloding the collectionView UI so we get latest results
            self.myTableView.reloadData()
            // Ending the refresh UI
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Error Setup
    /// Error Setup
    ///
    /// This will happen when API call is failure and
    /// viewModel has some error to feed to view
    private func setupErrorScreen(result: DataWrapper<StoreData>) {
        guard result.error != nil else {return}
        Task {
            self.loader.hideLoader(view: self.view)
            self.view.addSubview(self.error.view)
            self.myTableView.removeFromSuperview()
            
            setSliderValue(value: 0)
            
            // Ending the refresh UI
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - TableView Setup
    /// Setting TableView properties
    private func setupTableView() {
        myTableView = UITableView(frame: view.frame)
        
        // Dismiss the keyboard when the table view is dragged
        myTableView.keyboardDismissMode = .onDrag
        
        myTableView.separatorStyle = .none
        
        myTableView.backgroundColor = .white
        
        myTableView.contentInset = UIEdgeInsets(top: 39, left: 0, bottom: 0, right: 0)
        
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier:  ProductListingTableItem.identifer)
        myTableView.rowHeight = UITableView.automaticDimension

        myTableView.dataSource = self
        myTableView.delegate = self
    }
}

extension ProductListingTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - UITableView Item Click Handler
    /// UITableView - Item click handler
    ///
    /// It will take user to the appropriate screen with cell data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailsVC = ItemDetailsViewController(itemDetails: storeItems[indexPath.item]) as UIViewController
        self.navigationController?.pushViewController(productDetailsVC, animated: true)
    }
    
    // MARK: - UITableView Item count
    /// UITableView - Item count that is coming from API
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    // MARK: - UITableView Data
    /// UITableView - Setting data to custom cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListingTableItem.identifer, for: indexPath) as! ProductListingTableItem
        cell.itemName.text = storeItems[indexPath.row].name
        cell.itemPrice.text = storeItems[indexPath.row].price
        cell.extra.text = storeItems[indexPath.row].extra
        cell.itemImage.setCustomImage(storeItems[indexPath.row].image ?? "")
        return cell
    }
}


extension ProductListingTableViewController: UISearchBarDelegate {
    // MARK: - SearchBar listener
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        self.searchDelegate.searchBar?(searchBar, textDidChange: textSearched)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            viewModel.searchStore(searchedStore: textSearched)
        }
    }
}
