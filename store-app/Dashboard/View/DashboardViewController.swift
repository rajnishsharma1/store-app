//
//  ViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 13/02/23.
//

import UIKit

class DashboardViewController: UITabBarController {
    private var header = HeaderViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        CoreDatahelper.instance.fetchFromCoreData()
        createbottomNavBar()
        view.addSubview(header.view)
    }
    
    private func createbottomNavBar() {
        let vc1 = UINavigationController(rootViewController: ProductListingTableViewController())
        let vc2 = UINavigationController(rootViewController: ProductListingCollectionViewController())
        
    
        self.setViewControllers([vc1, vc2], animated: false)
        
        guard let items = self.tabBar.items else {
            return
        }
        
        let tabBarImageItem = ["tablecells", "rectangle.grid.3x2"]
        let tabBarImageSelectedItem = ["tablecells.fill", "rectangle.grid.3x2.fill"]
        
        for i in 0..<items.count {
            items[i].selectedImage = UIImage(systemName: tabBarImageSelectedItem[i])
            items[i].image = UIImage(systemName: tabBarImageItem[i])
        }
        
        self.modalPresentationStyle = .fullScreen
        self.tabBar.backgroundColor = .white
    }
}
