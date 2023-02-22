//
//  ViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 13/02/23.
//

import UIKit

class DashboardViewController: UITabBarController, UISearchBarDelegate {
    private var header: HeaderViewController = HeaderViewController()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        if (searchBar.text != nil && searchBar.text!.count > 3) {
            StoreViewModel.instance.searchStore(searchedStore: searchBar.text ?? "")
        } else {
            StoreViewModel.instance.resetSearch()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if header.searchBar.canResignFirstResponder {
            header.searchBar.resignFirstResponder()
        }
    }
    
    func didPresentSearchController(searchController: UISearchController) {
        if header.searchBar.canBecomeFirstResponder {
            header.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Lifecycle
    /// Lifecycle of DashBoardViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(header.view)
        header.searchBar.delegate = self
        createbottomNavBar()
    }
    
    // MARK: - Bottom Navigation bar
    /// Creation of bottom navigation bar and adding custom properties
    private func createbottomNavBar() {
        let vc1 = UINavigationController(rootViewController: ProductListingTableViewController())
        let vc2 = UINavigationController(rootViewController: ProductListingCollectionViewController())
        
        // Empty tabs
        let vc3 = UINavigationController(rootViewController: EmptyViewController())
        let vc4 = UINavigationController(rootViewController: EmptyViewController())
        let vc5 = UINavigationController(rootViewController: EmptyViewController())
        
        self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        
        // Checking if tab bar is not empty
        guard let items = self.tabBar.items else {
            return
        }

        // Updating image on tab bar button
        for i in 0..<items.count {
            items[i].image = UIImage(named: Strings.tabButtonImage)
        }
        
        // Tabbar custom properties
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = UIColor(named: Strings.tabBackgroundColor)
        
        // Tabbar button tint color
        // Setting green color for active tab button
        self.tabBar.tintColor = UIColor(named: Strings.tabButtonColor)
        
       initSwipe()
    }
    
    // MARK: - Initiliziing Swipe functionality
    /// This function will initilize the swipe variable and set its properties
    ///
    /// - Its directions
    /// - Number of tuches required for swipe functionality to work
    private func initSwipe() {
        var swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
        swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
    
    // MARK: - Swipe gesture controller
    // Swipe gestures logic
    @objc private func swipeGesture(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .right:
            if (selectedIndex > 0) {
                self.selectedIndex = self.selectedIndex - 1
            }
            break
        case .left:
            if (selectedIndex < 5) {
                self.selectedIndex = self.selectedIndex + 1
            }
            break
        default:
            break
        }
    }
    
    // MARK: - Subview Lifecycle
    /// Updating bottom Navigation height
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 95
        tabBar.frame.origin.y = view.frame.height - 95
    }
}
