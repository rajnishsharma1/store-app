//
//  ProductListingTableViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NetworkDelegate {
    
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
    
    var searchDelegate: UISearchBarDelegate!
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        view.backgroundColor = .white
        
        viewModel.networkDelegate = self
        
        /// Fetching data from Api
        fetchData()
        
        /// Setting up layouts
        setupTableView()
        
        /// Setting up pull to request
        setupPullToRefresh()
    }
    
    // MARK: - SearchBar listener
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        self.searchDelegate.searchBar?(searchBar, textDidChange: textSearched)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            viewModel.searchStore(searchedStore: textSearched)
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
       fetchData()
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
                self.view.addSubview(self.myTableView)
                
                // Reloding the collectionView UI so we get latest results
                self.myTableView.reloadData()
                
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
                self.myTableView.removeFromSuperview()
                // Ending the refresh UI
                if (self.refreshControl.isRefreshing) {
                    self.refreshControl.endRefreshing()
                }
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
        
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier:  ProductListingTableItem.identifer)
        myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)

        myTableView.dataSource = self
        myTableView.delegate = self
    }
}
