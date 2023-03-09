//
//  TabbarController.swift
//  store-app
//
//  Created by Rajnish Sharma on 23/02/23.
//

import Foundation
import UIKit

class AppViewController: UITabBarController, SideMenuDelegate {
    
    // MARK: - UI elements
    private var header: HeaderViewController = HeaderViewController()
    let firstController = ProductListingTableViewController()
    let secondController = ProductListingCollectionViewController()
    
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.50
    var isSlideInMenuPresented = false
    
    lazy var menuViewController = MenuViewController()
    
    // MARK: - Tab Image
    let tabBarImage: UIImage = UIImage(named: Strings.activeTabButtonImage)!
    
    // MARK: - Lifecycle
    /// Lifecycle
    override func viewDidLoad() {
        self.delegate = self
        
        tabBar.backgroundColor = UIColor(named: Strings.tabBackgroundColor)
        
        setUpPageView()
        
        self.selectPage(at: 0)
        
        setupSideMenu()
    }
    
    // Delegate method that tells if the side menu was triggered.
    func menuButtonTapped() {
        self.menuViewController.view.isHidden.toggle()
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.menuViewController.view.frame.size = CGSize(width: self.view.frame.width * 1, height: self.menuViewController.view.frame.height)
        } completion: { (finished) in
            
        }
    }
    
    /// Setup the Side Menu
    private func setupSideMenu() {
        menuViewController.menuButtonDelegate = self
        menuViewController.view.pinMenuTo(view, with: slideInMenuPadding)
        menuViewController.view.isHidden = true
        menuViewController.view.frame.size = CGSize(width: 0, height: self.menuViewController.view.frame.height)
        menuViewController.view.accessibilityIdentifier = "MenuViewController"
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
        
        let thirdController = EmptyViewController()
        let fourthController = EmptyViewController()
        let fifthController = EmptyViewController()
        
        header.searchBar.delegate = firstController
        header.menuButtonDelegate = self
        firstController.searchDelegate = secondController
        
        view.addSubview(header.view)
        
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
        let tableItem = UITabBarItem(title: nil, image: self.tabBarImage, selectedImage: nil)
        tableItem.imageInsets = UIEdgeInsets(top: 14.5, left: 0, bottom: -14.5, right: 0)
        return tableItem
    }
    
    // MARK: - Tab Bar Item Change
    private func handleTabbarItemChange(viewController: UIViewController) {
        guard let viewControllers = self.viewControllers else { return }
        let selectedIndex = viewController.view.tag
        self.tabBar.tintColor = UIColor(named: Strings.unselectedTabButtonBackgroundColor)
        self.tabBar.unselectedItemTintColor = UIColor(named: Strings.unselectedTabButtonBackgroundColor)
        
        if selectedIndex == 0 {
            header.filterDelegate = firstController
        } else if selectedIndex == 1 {
            header.filterDelegate = secondController as? any FilterDelegate
        }
        
        for i in 0..<viewControllers.count {
            let tabbarItem = viewControllers[i].tabBarItem
            let tabbarImage = self.tabBarImage
            tabbarItem?.selectedImage = tabbarImage.withRenderingMode(.alwaysTemplate)
            tabbarItem?.image = tabbarImage.withRenderingMode(
                i == selectedIndex ? .alwaysOriginal : .alwaysTemplate
            )
        }
        
        if selectedIndex == 1 {
            viewControllers[selectedIndex].tabBarItem.selectedImage = self.tabBarImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    // MARK: - SearchBar Button Click
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.canResignFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}


extension AppViewController: UITabBarControllerDelegate, PageViewControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        self.selectPage(at: viewController.view.tag)
        return false
    }
    
    func pageDidSwipe(to index: Int) {
        guard let viewController = self.viewControllers?[index] else { return }
        self.handleTabbarItemChange(viewController: viewController)
    }
}


public extension UIView {
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
