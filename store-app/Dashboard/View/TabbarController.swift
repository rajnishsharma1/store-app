//
//  TabbarController.swift
//  store-app
//
//  Created by Rajnish Sharma on 23/02/23.
//

import Foundation
import UIKit

class TabbarController: UITabBarController , UISearchBarDelegate{
    
    // MARK: - UI elements
    private var header: HeaderViewController = HeaderViewController()
    
    // MARK: - Tab Image
    let tabBarImages = [
        UIImage(named: Strings.activeTabButtonImage)!,
        UIImage(named: Strings.activeTabButtonImage)!,
        UIImage(named: Strings.activeTabButtonImage)!,
        UIImage(named: Strings.activeTabButtonImage)!,
        UIImage(named: Strings.activeTabButtonImage)!
    ]
    
    // MARK: - Lifecycle
    /// Lifecycle
    override func viewDidLoad() {
        self.delegate = self
        view.addSubview(header.view)
        
        tabBar.backgroundColor = UIColor(named: Strings.tabBackgroundColor)
        
        header.searchBar.delegate = self
        
        setUpPageView()
        
        self.selectPage(at: 0)
    }
    
    // MARK: - Page View Setup
    /// PageView Setup
    private func setUpPageView() {
        guard let centerPageViewController = createCenterPageViewController() else { return }
        
        var controllers: [UIViewController] = []
        
        controllers.append(createPlaceholderViewController(forIndex: 0))
        controllers.append(centerPageViewController)
        controllers.append(createPlaceholderViewController(forIndex: 2))
        controllers.append(createPlaceholderViewController(forIndex: 3))
        controllers.append(createPlaceholderViewController(forIndex: 4))
        
        setViewControllers(controllers, animated: false)
        
        selectedViewController = centerPageViewController
    }
    
    // MARK: - Select Page from PageView
    private func selectPage(at index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
        guard let PageViewController = (self.viewControllers?[1] as? PageViewController) else { return }
        PageViewController.selectPage(at: index)
    }
    
    // MARK: - Placeholder ViewController
    private func createPlaceholderViewController(forIndex index: Int) -> UIViewController {
        let emptyViewController = UIViewController()
        emptyViewController.tabBarItem = tabbarItem(at: index)
        emptyViewController.view.tag = index
        return emptyViewController
    }
    
    // MARK: - Center Page ViewController
    private func createCenterPageViewController() -> UIPageViewController? {
        
        let firstController = ProductListingTableViewController()
        let secondController = ProductListingCollectionViewController()
        let thirdController = EmptyViewController()
        let fourthController = EmptyViewController()
        let fifthController = EmptyViewController()
        
        firstController.view.tag = 0
        secondController.view.tag = 1
        thirdController.view.tag = 2
        fourthController.view.tag = 3
        fifthController.view.tag = 4
        
        firstController.view.backgroundColor = UIColor.white
        secondController.view.backgroundColor = UIColor.white
        thirdController.view.backgroundColor = UIColor.white
        fourthController.view.backgroundColor = UIColor.white
        fifthController.view.backgroundColor = UIColor.white
        
        let pageViewController = PageViewController()
        
        pageViewController.pages = [firstController, secondController, thirdController, fourthController, fifthController]
        pageViewController.tabBarItem = tabbarItem(at: 1)
        pageViewController.view.tag = 1
        pageViewController.swipeDelegate = self
        
        return pageViewController
    }
    
    // MARK: - Tab Bar Item
    private func tabbarItem(at index: Int) -> UITabBarItem {
        let tableItem = UITabBarItem(title: nil, image: self.tabBarImages[index], selectedImage: nil)
        tableItem.imageInsets = UIEdgeInsets(top: 14.5, left: 0, bottom: -14.5, right: 0)
        return tableItem
    }
    
    // MARK: - Tab Bar Item Change
    private func handleTabbarItemChange(viewController: UIViewController) {
        guard let viewControllers = self.viewControllers else { return }
        let selectedIndex = viewController.view.tag
        self.tabBar.tintColor = UIColor(named: Strings.unselectedTabButtonBackgroundColor)
        self.tabBar.unselectedItemTintColor = UIColor(named: Strings.unselectedTabButtonBackgroundColor)
        
        for i in 0..<viewControllers.count {
            let tabbarItem = viewControllers[i].tabBarItem
            let tabbarImage = self.tabBarImages[i]
            tabbarItem?.selectedImage = tabbarImage.withRenderingMode(.alwaysTemplate)
            tabbarItem?.image = tabbarImage.withRenderingMode(
                i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
            )
        }
        
        if selectedIndex == 1 {
            viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImages[1].withRenderingMode(.alwaysOriginal)
        }
    }
    
    // MARK: - SearchBar listener
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        StoreViewModel.instance.searchStore(searchedStore: searchBar.text ?? "")
    }
    
    // MARK: - SearchBar Button Click
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if header.searchBar.canResignFirstResponder {
            header.searchBar.resignFirstResponder()
        }
    }
    
    // MARK: - SearchBar to become first responder
    func didPresentSearchController(searchController: UISearchController) {
        if header.searchBar.canBecomeFirstResponder {
            header.searchBar.becomeFirstResponder()
        }
    }
}


extension TabbarController: UITabBarControllerDelegate, PageViewControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.selectPage(at: viewController.view.tag)
        return false
    }
    
    func pageDidSwipe(to index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
    }
    
}

