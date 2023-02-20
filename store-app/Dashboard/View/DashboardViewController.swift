//
//  ViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 13/02/23.
//

import UIKit

class DashboardViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(HeaderViewController().view)
        createbottomNavBar()
    }
    
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
        
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = UIColor(named: Strings.tabBackgroundColor)
        self.tabBar.tintColor = UIColor(named: Strings.tabButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 95
        tabBar.frame.origin.y = view.frame.height - 95
    }
}
