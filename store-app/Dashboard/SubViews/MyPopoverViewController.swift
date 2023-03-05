//
//  MyPopViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 02/03/23.
//

import UIKit

class MyPopoverViewController: UIViewController {

    // UIElements
    private let popoverLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting background color as white
        view.backgroundColor = .white
        self.preferredContentSize = CGSize(width: 200, height: 200)
        // UI Properties of popover label
        popoverLabel.text = "Filter Popover"
        popoverLabel.textAlignment = .center
        
        popoverLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popoverLabel)
        
        setupPopoverLabelConstraints()
    }
    
    private func setupPopoverLabelConstraints() {
        let labelTop = NSLayoutConstraint(item: popoverLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        
        let labelLeading = NSLayoutConstraint(item: popoverLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        
        let labelTrailing = NSLayoutConstraint(item: popoverLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let labelBottom = NSLayoutConstraint(item: popoverLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([labelTop, labelLeading, labelTrailing, labelBottom])
    }
}
