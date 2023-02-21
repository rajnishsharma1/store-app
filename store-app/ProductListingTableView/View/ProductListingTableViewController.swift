//
//  ProductListingTableViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit
import Combine

class ProductListingTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    /// Data Objects
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    
    // Defines a cancellable object to retrive the state of the network calls
    private var cancellable: AnyCancellable?
    
    private var viewModel: StoreViewModel = StoreViewModel()
    
    /// UI Elements
    private var myTableView: UITableView!
    private var loader: LoaderView = LoaderView()
    private var error: ErrorView = ErrorView()
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
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
        setupTableView()
        
        /// Observing publisher in ViewModel
        viewModelListener()
        
        /// Setting up pull to request
        setupPullToRefresh()
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
        cell.itemImage.setCustomImage(storeItems[indexPath.row].image)
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
                    self.view.addSubview(self.myTableView)
                    
                    // Ending the refresh UI
                    if (self.refreshControl.isRefreshing) {
                        self.refreshControl.endRefreshing()
                    }
                }
            } else if ($0.error != nil){
                guard let error = $0.error else {return}
                Task {
                    self.loader.hideLoader(view: self.view)
                    self.error.showError(view: self.view, errorText: error)
                    
                    // Ending the refresh UI
                    if (self.refreshControl.isRefreshing) {
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
    
    // MARK: - TableView Setup
    /// Setting TableView properties
    private func setupTableView() {
        myTableView = UITableView(frame: view.frame)
        
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier:  ProductListingTableItem.identifer)
        myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)

        myTableView.dataSource = self
        myTableView.delegate = self
    }
}
