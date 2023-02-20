//
//  ViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 13/02/23.
//

import UIKit

class DashboardViewController: UITabBarController {
    
    // MARK: - Lifecycle
    /// Lifecycle of DashBoardViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(HeaderViewController().view)
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
        self.tabBar.tintColor = UIColor(named: Strings.tabButton)
    }
    
    // MARK: - Subview Lifecycle
    /// Updating bottom Navigation height
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 95
        tabBar.frame.origin.y = view.frame.height - 95
    }
}
