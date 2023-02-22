//
//  HeaderViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

class HeaderViewController : UIViewController {
    var searchBar: UISearchBar = UISearchBar()
    private var exploreLabel: UILabel = UILabel()
    private var filterLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Visual properties of root view
        view.backgroundColor = UIColor(named: Strings.headerBackgroundColor)
        view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 164)

        // Visual properties of exploreLabel
        filterLabel.text = Strings.filer
        filterLabel.font = UIFont.systemFont(ofSize: 16)
        filterLabel.textColor = UIColor(named: Strings.filterTextColor)
        
        // Visual properties of exploreLabel
        exploreLabel.text = Strings.explore
        exploreLabel.textColor = .black
        exploreLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        // Visual properties of searchBar
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 25
        searchBar.barStyle = UIBarStyle.black
        searchBar.placeholder = Strings.search
        searchBar.backgroundColor = UIColor.white
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        exploreLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding views to subview
        view.addSubview(searchBar)
        view.addSubview(exploreLabel)
        view.addSubview(filterLabel)
        
        addExploreLabelConstraint()
        addFilterLabelConstraint()
        addSearchBarConstraint()
    }
    
    // MARK: - Constraints for Explore Label
    /// Constraints for Explore label
    private func addExploreLabelConstraint() {
        let labelTop = NSLayoutConstraint(item: exploreLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 55)
        
        let labelLeading = NSLayoutConstraint(item: exploreLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 49)
        
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
}
