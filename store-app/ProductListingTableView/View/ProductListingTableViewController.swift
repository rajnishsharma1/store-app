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
    
    private var viewModel: StoreViewModel = StoreViewModel()
    
    /// UI Elements
    private var myTableView: UITableView!
    private var loader: LoaderView = LoaderView()
    private var error: ErrorViewController = ErrorViewController()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let slider = UISlider()
    
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
    
    private func setupSlider(listLength: Float) {
        slider.minimumValue = 0
        slider.maximumValue = listLength
        slider.value = Float(storeItems.count)
        slider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
    }
    
    @objc func sliderValueDidChange(sender: UISlider) {
        viewModel.updateResponseBySlider(sliderValue: sender)
    }
    
    // MARK: - Pull to refresh callback
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
    }
    
    // Add Constraints for the Slider
     func addSliderConstraint() {
         slider.translatesAutoresizingMaskIntoConstraints = false
         
         let sliderTop = NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: myTableView, attribute: .bottom, multiplier: 1, constant: 10)
         let sliderBottom = NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
         let sliderLeading = NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
         let sliderTrailing = NSLayoutConstraint(item: slider, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
         
         self.view.addConstraints([sliderTop, sliderBottom, sliderLeading, sliderTrailing])
     }
    
    // Add Constraints for the TableView
    func addTableViewConstraints() {
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableTop = NSLayoutConstraint(item: myTableView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 150)
        let tableWidth = NSLayoutConstraint(item: myTableView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([tableTop, tableWidth])
    }
    
    // MARK: Pull To Refresh
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
    
    func updateChanges(result: DataWrapper<StoreData>) {
        if (result.isLoading == true) {
            setupLoader()
        } else if (result.response != nil) {
            setupPostResponseScreen(result: result)
        } else if (result.error != nil) {
            setupErrorScreen(result: result)
        }
    }
    
    private func setupLoader() {
        Task {
            if (!self.refreshControl.isRefreshing) {
                self.loader.showLoader(view: self.view)
            }
            self.error.view.removeFromSuperview()
        }
    }
    
    private func setupPostResponseScreen(result: DataWrapper<StoreData>) {
        guard let response = result.response else {return}
        Task {
            self.storeItems = response.items
            self.view.addSubview(self.myTableView)
            self.view.addSubview(self.slider)
            
            self.addTableViewConstraints()
            self.addSliderConstraint()
            setupSlider(listLength: Float(storeItems.count))
            self.slider.value = Float(response.items.count)
            
            // Reloding the collectionView UI so we get latest results
            self.myTableView.reloadData()
            print("New value \(response.items.count)")
          
            
            // Ending the refresh UI
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    private func setupErrorScreen(result: DataWrapper<StoreData>) {
        guard result.error != nil else {return}
        Task {
            self.loader.hideLoader(view: self.view)
            self.view.addSubview(self.error.view)
            self.myTableView.removeFromSuperview()
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
        
        myTableView.contentInset = UIEdgeInsets(top: 19, left: 0, bottom: 0, right: 0)
        
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier:  ProductListingTableItem.identifer)
        myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)

        myTableView.dataSource = self
        myTableView.delegate = self
    }
}

extension ProductListingTableViewController: UITableViewDataSource, UITableViewDelegate {
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
