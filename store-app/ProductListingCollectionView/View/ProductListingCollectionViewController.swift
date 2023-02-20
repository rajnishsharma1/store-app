//
//  ProductListingCollectionViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit
import Combine

class ProductListingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //MARK: - Properties
    // Defines a cancellable object to retrive the state of the network calls
    private var cancellable: AnyCancellable?
    
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    private var viewModel: StoreViewModel = StoreViewModel()
    
    /// UI Elements
    private var loader: LoaderView = LoaderView()
    private var error: ErrorView = ErrorView()
    var myCollectionView: UICollectionView!
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        error = ErrorView(frame: view.frame)
        view.backgroundColor = .white
        
        /// Fetching data from Api
        fetchData()
        
        /// Setting up layouts
        setupCollectionView()
        
        /// Observing publisher in ViewModel
        viewModelListener()
    }
    
    // MARK: - CollectionView customizations
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 166)
        layout.scrollDirection = .vertical
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        myCollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        myCollectionView?.backgroundColor = UIColor.white
        myCollectionView?.register(ProductListingCollectionItem.self, forCellWithReuseIdentifier: ProductListingCollectionItem.identifer)
        
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
                Task {self.loader.showLoader(view: self.view)}
            } else if ($0.response != nil) {
                guard let response = $0.response else {return}
                Task {
                    self.storeItems = response.items
                    let uiScroll = UIScrollView(frame: self.view.frame)
                    self.myCollectionView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)
                    uiScroll.addSubview(self.myCollectionView)
                    self.view.addSubview(uiScroll)
                }
            } else if ($0.error != nil){
                guard let error = $0.error else {return}
                Task {
                    self.error.showError(view: self.view, errorText: error)
                    self.loader.hideLoader(view: self.view)
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
        myCell.itemImage.setCustomImage(storeItems[indexPath.row].image)
        return myCell
    }
}
