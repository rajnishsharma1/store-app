//
//  ProductListingCollectionViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit
import Combine

class ProductListingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    // Defines a cancellable object to retrive the state of the network calls
    private var cancellable: AnyCancellable?
    
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    private var viewModel: StoreViewModel = StoreViewModel.instance
    
    /// UI Elements
    private var loader: LoaderView = LoaderView()
    private var error: ErrorView = ErrorView()
    private var myCollectionView: UICollectionView!
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        error = ErrorView(frame: view.frame)
        view.backgroundColor = .white
        
        /// Setting up layouts
        setupCollectionView()
        
        /// Observing publisher in ViewModel
        viewModelListener()
        
        /// Setting up pull to request
        setupPullToRefresh()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
    }
    
    // MARK: - CollectionView customizations
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        // Setting section layout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32)
        layout.scrollDirection = .vertical
        
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
    
    // MARK: ViewModel listener
    /// Listening the changes in the viewmodel's publisher
    private func viewModelListener() {
        cancellable = viewModel.$store.sink {
            if ($0.isLoading == true) {
                Task {
                    if (!self.refreshControl.isRefreshing) {
                        self.loader.showLoader(view: self.view)
                    }
                }
            } else if ($0.response != nil) {
                guard let response = $0.response else {return}
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
            } else if ($0.error != nil){
                guard let error = $0.error else {return}
                Task {
                    self.error.showError(view: self.view, errorText: error)
                    self.loader.hideLoader(view: self.view)
                    self.myCollectionView.removeFromSuperview()
                    // Ending the refresh UI
                    if (self.refreshControl.isRefreshing) {
                        self.refreshControl.endRefreshing()
                    }
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
