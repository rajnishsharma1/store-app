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
    // To store list of items that we receive from the api
    private var storeItems: [ItemModel] = []
    
    // Defines a cancellable object to retrive the state of the network calls
    private var cancellable: AnyCancellable?
    
    private var viewModel: StoreViewModel = StoreViewModel()
    
    private var myTableView: UITableView!
    private var loader: LoaderView = LoaderView()
    private var error: ErrorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader = LoaderView(frame: view.frame)
        error = ErrorView(frame: view.frame)
        view.backgroundColor = .white
        
        fetchData()
        setupTableView()
        viewModelListener()
    }
    
    private func fetchData() {
        Task {await viewModel.getStoreDetails()}
    }
    
    private func viewModelListener() {
        cancellable = viewModel.$store.sink {
            print($0.isLoading)
            if ($0.isLoading == true) {
                
                Task {self.loader.showLoader(view: self.view)}
                print("here3")
            } else if ($0.response != nil) {
                guard let response = $0.response else {return}
                Task {
                    self.storeItems = response.items
                    let uiScroll = UIScrollView(frame: self.view.frame)
                    uiScroll.addSubview(self.myTableView)
                    self.myTableView.frame = CGRect(x: 0, y: 164, width: self.view.frame.size.width, height: self.view.frame.size.height - 164)
                    self.view.addSubview(uiScroll)
                }
                print("here2")
            } else if ($0.error != nil){
                Task {self.error.showError(view: self.view)}
                Task {self.loader.hideLoader(view: self.view)}
                print("here")
            }
        }
    }
    
    private func setupTableView() {
        myTableView = UITableView(frame: view.frame)
        
        myTableView.register(ProductListingTableItem.self, forCellReuseIdentifier:  ProductListingTableItem.identifer)
        myTableView.rowHeight = UITableView.automaticDimension

        myTableView.dataSource = self
        myTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListingTableItem.identifer, for: indexPath) as! ProductListingTableItem
        cell.itemName.text = storeItems[indexPath.row].name
        cell.itemPrice.text = storeItems[indexPath.row].price
        cell.extra.text = storeItems[indexPath.row].extra
        cell.itemImage.setCustomImage(storeItems[indexPath.row].image)
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
