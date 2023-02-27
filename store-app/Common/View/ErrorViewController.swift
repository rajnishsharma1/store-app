//
//  ErrorView.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation

import UIKit

class ErrorViewController: UIViewController {
    /// UI Element
    private var errorLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Properties for Error Label
        errorLabel.text = Strings.errorMessage
        errorLabel.textAlignment = .center
        errorLabel.textColor = .gray
        errorLabel.font = UIFont.systemFont(ofSize: 18)
        
        view.addSubview(errorLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addErrorLabelContstraint()
    }
    
    // MARK: - Constraints for Error Label
    /// Constraints for Error label
    private func addErrorLabelContstraint() {
        let errorLabelTop = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height * 0.5)

        let errorLabelLeading = NSLayoutConstraint(item: errorLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let errorLabelTrailing = NSLayoutConstraint(item: errorLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        view.addConstraints([errorLabelTop, errorLabelLeading, errorLabelTrailing])
    }
}
