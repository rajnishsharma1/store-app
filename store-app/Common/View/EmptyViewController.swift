//
//  EmptyViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 17/02/23.
//

import Foundation
import UIKit

class EmptyViewController: UIViewController {
    private let emptyLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    /// Lifecycle
    /// Initial Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        emptyLabel.text = Strings.comingSoon
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .gray
        emptyLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        view.addSubview(emptyLabel)
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addEmptyLabelContstraint()
    }
    
    // MARK: - Constraints for Empty Label
    /// Adding constraints for Empty label
    private func addEmptyLabelContstraint() {
        let emptyLabelTop = NSLayoutConstraint(item: emptyLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)

        let emptyLabelLeading = NSLayoutConstraint(item: emptyLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let emptyLabelTrailing = NSLayoutConstraint(item: emptyLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        let emptyLabelBottom = NSLayoutConstraint(item: emptyLabel, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([emptyLabelTop, emptyLabelLeading, emptyLabelTrailing, emptyLabelBottom])
    }
}
