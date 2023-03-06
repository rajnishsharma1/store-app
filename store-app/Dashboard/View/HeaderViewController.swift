//
//  HeaderViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

class HeaderViewController : UIViewController, UIPopoverPresentationControllerDelegate {
    
    //MARK: - UI Elements
    /// UI Elements
    var searchBar: UISearchBar = UISearchBar()
    private var exploreLabel: UILabel = UILabel()
    private var filterLabel: UILabel = UILabel()
    private var menuButton: UIButton = UIButton()
    
    var filterDelegate: FilterDelegate!
    
    // MARK: - Lifecycle
    /// ViewDidLoad Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Visual properties of root view
        view.backgroundColor = UIColor(named: Strings.headerBackgroundColor)
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 164)
        
        // Visual properties of exploreLabel
        setupFilterLabel()
        
        // Visual properties of exploreLabel
        setupExploreLabel()
        
        // Visual properties of searchBar
        setupSearchBar()
        
        setupMenuButton()
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding views to subview
        view.addSubview(searchBar)
        view.addSubview(exploreLabel)
        view.addSubview(filterLabel)
        view.addSubview(menuButton)
        
        addExploreLabelConstraint()
        addMenuConstraint()
        addFilterLabelConstraint()
        addSearchBarConstraint()
    }
    
    // MARK: - Filter Label properties
    /// Filter Label properties
    private func setupFilterLabel() {
        filterLabel.text = Strings.filer
        filterLabel.font = UIFont.systemFont(ofSize: 16)
        filterLabel.textColor = UIColor(named: Strings.filterTextColor)
        
        // Handling clicks
        filterLabel.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.onFilterTap))
        filterLabel.addGestureRecognizer(labelTapGesture)
    }
    
    // MARK: - Filter tap
    /// Filter tap listener
    @objc func onFilterTap() {
        filterDelegate.filterClickFrom(tabName: "")
        // Get a reference to the view controller for the popover
        let popController = MyPopoverViewController()

        // Set the presentation style
        popController.modalPresentationStyle = .popover

        // Set up the popover presentation controller
        popController.popoverPresentationController?.permittedArrowDirections = .up
        popController.popoverPresentationController?.delegate = self
        popController.popoverPresentationController?.sourceView = filterLabel
        popController.popoverPresentationController?.sourceRect = filterLabel.bounds

        // present the popover
        self.present(popController, animated: true, completion: nil)
    }
    
    // MARK: - Popover Presentation style
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Menu tap handler
    @objc private func onMenuTap() {
        
    }
    
    // MARK: - Setup menu button
    /// Setup menu button
    private func setupMenuButton() {
        menuButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuButton.tintColor = .gray
        menuButton.isUserInteractionEnabled = true
        menuButton.addTarget(self, action: #selector(onMenuTap), for: .touchDown)
    }
    
    // MARK: - Explore Label properties
    /// Explore Label properties
    private func setupExploreLabel() {
        exploreLabel.text = Strings.explore
        exploreLabel.textColor = .black
        exploreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    // MARK: - Search Bar properties
    /// Search bar properties
    private func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 25
        searchBar.barStyle = UIBarStyle.black
        searchBar.placeholder = Strings.search
        searchBar.backgroundColor = UIColor.white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    // MARK: - Constraints for Explore Label
    /// Constraints for Explore label
    private func addExploreLabelConstraint() {
        let labelTop = NSLayoutConstraint(item: exploreLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 55)
        
        let labelLeading = NSLayoutConstraint(item: exploreLabel, attribute: .leading, relatedBy: .equal, toItem: menuButton, attribute: .leading, multiplier: 1, constant: 30)
        
        view.addConstraints([labelTop, labelLeading])
    }
    
    // MARK: - Constraints for Filter Label
    /// Constraints for Explore label
    private func addFilterLabelConstraint() {
        let filterTop = NSLayoutConstraint(item: filterLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 55)
        
        let filterTrailing = NSLayoutConstraint(item: filterLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -34)
        
        view.addConstraints([filterTop, filterTrailing])
    }
    
    // MARK: - Constraints for Search Bar
    /// Constraints for Explore label
    private func addSearchBarConstraint() {
        let searchBarTop = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: exploreLabel, attribute: .bottom, multiplier: 1, constant: 15)
        
        let searchLeading = NSLayoutConstraint(item: searchBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 34)
        
        let searchHeight = NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        let searchTrailing = NSLayoutConstraint(item: searchBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -34)
        
        view.addConstraints([searchBarTop, searchLeading, searchHeight, searchTrailing])
    }
    
    // MARK: - Menu constraint
    /// Constraints for Manu button
    private func addMenuConstraint() {
        let menuTop = NSLayoutConstraint(item: menuButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 55)
        
        let menuLeading = NSLayoutConstraint(item: menuButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 49)
        
        view.addConstraints([menuTop, menuLeading])
    }
}
