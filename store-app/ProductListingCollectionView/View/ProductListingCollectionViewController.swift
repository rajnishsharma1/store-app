//
//  ProductListingCollectionViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NetworkDelegate {
   
    //MARK: - Properties
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    private var viewModel: StoreViewModel = StoreViewModel()
    
    /// UI Elements
    private var loader: LoaderView = LoaderView()
    private var error: ErrorViewController = ErrorViewController()
    private var myCollectionView: UICollectionView!
    
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
    
    // MARK: - SearchBar listener
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        viewModel.searchStore(searchedStore: textSearched)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
    }
    
    // MARK: - CollectionView customizations
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
            Task {
                if (!self.refreshControl.isRefreshing) {
                    self.loader.showLoader(view: self.view)
                }
                self.error.view.removeFromSuperview()
            }
        } else if (result.response != nil) {
            guard let response = result.response else {return}
            Task {
                self.storeItems = response.items
                self.view.addSubview(self.myCollectionView)
                
                // Reloding the collectionView UI so we get latest results
                self.myCollectionView.reloadData()
                
                // Ending the refresh UI
                if (self.refreshControl.isRefreshing) {
                    self.refreshControl.endRefreshing()
                }
            }
        } else if (result.error != nil){
            guard result.error != nil else {return}
            Task {
                self.loader.hideLoader(view: self.view)
                self.view.addSubview(self.error.view)
                self.myCollectionView.removeFromSuperview()
                // Ending the refresh UI
                if (self.refreshControl.isRefreshing) {
                    self.refreshControl.endRefreshing()
                }
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
}
