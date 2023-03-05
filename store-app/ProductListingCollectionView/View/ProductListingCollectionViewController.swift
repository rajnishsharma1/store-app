//
//  ProductListingCollectionViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NetworkDelegate {
   
    // MARK: - Properties
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    private var masterStoreItems: [ItemModel] = []
    
    // MARK: - ViewModel
    /// Viewmodel
    private var viewModel: StoreViewModel = StoreViewModel()
    
    // MARK: - UI Elements
    /// UI Elements
    private var loader: LoaderView = LoaderView()
    private var error: ErrorViewController = ErrorViewController()
    private var myCollectionView: UICollectionView!
    private let slider: UISlider = UISlider()
    private let sliderLabel: UILabel = UILabel()
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        view.backgroundColor = .white
        
        /// Setting network delegate
        viewModel.networkDelegate = self
        
        /// Fetching data from API
        fetchData()
        
        /// Setting up layouts
        setupCollectionView()
        
        /// Setting up pull to request
        setupPullToRefresh()
    }
    
    // MARK: - Setup Slider
    /// Setup Slider
    private func setupSlider() {
        slider.minimumValue = 0
        slider.maximumValue = Float(storeItems.count)
        slider.value = Float(storeItems.count)
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
        
        myCollectionView.reloadData()
    }
    
    // MARK: - Set Slider Value
    /// Setting slider value
    private func setSliderValue(value: Float) {
        slider.setValue(value, animated: false)
        sliderLabel.text = String(Int(value))
    }
    
    // MARK: - SearchBar listener
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        viewModel.searchStore(searchedStore: textSearched)
    }
    
    // MARK: - Pull to refresh callback
    /// Pull to refresh callback listener
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
    }
    
    // MARK: - Constraints for TableView
    // Add Constraints for the TableView
    private func addCollectionViewConstraints() {
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let collectionTop = NSLayoutConstraint(item: myCollectionView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 164)
        let collectionWidth = NSLayoutConstraint(item: myCollectionView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([collectionTop, collectionWidth])
    }
    
    // MARK: - Constraints for Slider
    // Add Constraints for the Slider
    private func addSliderConstraint() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        let sliderTop = NSLayoutConstraint(item: slider, attribute: .top, relatedBy: .equal, toItem: myCollectionView, attribute: .bottom, multiplier: 1, constant: 10)
        let sliderBottom = NSLayoutConstraint(item: slider, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
        let sliderLeading = NSLayoutConstraint(item: slider, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        
        self.view.addConstraints([sliderTop, sliderBottom, sliderLeading])
    }
    
    // MARK: - Constraints for SliderLabel
    // Add Constraints for the SliderLabel
    private func addSliderLabelConstraint() {
         sliderLabel.translatesAutoresizingMaskIntoConstraints = false
         
         let sliderLabelTop = NSLayoutConstraint(item: sliderLabel, attribute: .top, relatedBy: .equal, toItem: myCollectionView, attribute: .bottom, multiplier: 1, constant: 10)
         let sliderLabelBottom = NSLayoutConstraint(item: sliderLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -100)
         let sliderLabelLeading = NSLayoutConstraint(item: sliderLabel, attribute: .leading, relatedBy: .equal, toItem: slider, attribute: .trailing, multiplier: 1, constant: 20)
         let sliderLabelTrailing = NSLayoutConstraint(item: sliderLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
         
         self.view.addConstraints([sliderLabelTop, sliderLabelBottom, sliderLabelLeading, sliderLabelTrailing])
     }
    
    // MARK: - CollectionView setup
    /// CollectionView setup
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // Setting section layout
        layout.sectionInset = UIEdgeInsets(top: 39, left: 0, bottom: 0, right: 32)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        
        // Setting padding and axis values and UI Properties
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)
        myCollectionView.backgroundColor = UIColor.white
        
        // Dismiss the keyboard when the table view is dragged
        myCollectionView.keyboardDismissMode = .onDrag
        
        // Setting delegate and data source
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        // Setting bounce properties for Pull to refresh
        myCollectionView.bounces = true
        myCollectionView.alwaysBounceVertical = true
        
        // Regestering custom item as individual cell
        myCollectionView?.register(ProductListingCollectionItem.self, forCellWithReuseIdentifier: ProductListingCollectionItem.identifer)
    }
    
    // MARK: Pull To Refresh
    /// Pull to request setup
    private func setupPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        myCollectionView.addSubview(refreshControl)
    }
    
    // MARK: - Fetch Data from ViewModel
    /// Fetch data from ViewModel
    private func fetchData() {
        Task {await viewModel.getStoreDetails()}
    }
    
    func updateChanges(result: DataWrapper<StoreData>) {
        if (result.isLoading == true) {
            setupLoader()
        } else if (result.response != nil) {
            setupPostResponseScreen(result: result)
        } else if (result.error != nil){
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
            self.myCollectionView.removeFromSuperview()
            
            setSliderValue(value: 0)
            
            // Ending the refresh UI
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
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
            self.view.addSubview(self.myCollectionView)
            self.view.addSubview(self.slider)
            self.view.addSubview(self.sliderLabel)
            
            self.setupSlider()
            self.addCollectionViewConstraints()
            self.addSliderConstraint()
            self.addSliderLabelConstraint()
            
            // Reloding the collectionView UI so we get latest results
            self.myCollectionView.reloadData()
            
            // Ending the refresh UI
            if (self.refreshControl.isRefreshing) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - UICollectionView Item count
    /// UICollectionView - Item count that is coming from API
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    // MARK: - UICollectionView Data
    /// UICollectionView - Setting data to custom cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListingCollectionItem.identifer, for: indexPath) as! ProductListingCollectionItem
        myCell.itemName.text = storeItems[indexPath.row].name
        myCell.itemPrice.text = storeItems[indexPath.row].price
        myCell.itemImage.setCustomImage(storeItems[indexPath.row].image ?? "")
        return myCell
    }
    
    // MARK: Size of each Item
    /// Setting size for each item of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 110, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailsVC = ItemDetailsViewController(itemDetails: storeItems[indexPath.item], isDismissable: true)
        self.present(productDetailsVC, animated: true)
    }
}
