//
//  HeaderViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

class HeaderViewController : UIViewController, UISearchBarDelegate {
    private var searchBar: UISearchBar = UISearchBar()
    private var exploreLabel: UILabel = UILabel()
    private var filterLabel: UILabel = UILabel()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        print(searchBar.text!)
    }
    
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
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = UIColor.clear
        searchBar.layer.cornerRadius = 25
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
        
        // Mappding views to string to set the constraints
        let viewsDict = [
            "searchBar" : searchBar,
            "exploreLabel" : exploreLabel,
            "filterLabel" : filterLabel
        ] as [String : Any]
        
        // Adding contstraints for the view
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-55-[exploreLabel]", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-55-[filterLabel]", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[exploreLabel]-15-[searchBar(50)]", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[filterLabel]-15-[searchBar(50)]", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[exploreLabel]-[filterLabel]-20-|", options: [], metrics: nil, views: viewsDict))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[searchBar]-20-|", options: [], metrics: nil, views: viewsDict))
    }
}
