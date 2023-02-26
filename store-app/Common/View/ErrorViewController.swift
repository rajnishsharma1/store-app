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
    private var retryButton: UIButton = UIButton()
    
    private var viewModel: StoreViewModel = StoreViewModel.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Properties for Error Label
        errorLabel.text = Strings.errorMessage
        errorLabel.textAlignment = .center
        errorLabel.textColor = .gray
        errorLabel.font = UIFont.systemFont(ofSize: 18)
        
        // UI Properties for Retry Button
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.white, for: .normal)
        retryButton.setTitleColor(.black, for: .highlighted)
        retryButton.backgroundColor = .gray
        retryButton.layer.cornerRadius = 15
        retryButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        view.addSubview(errorLabel)
        view.addSubview(retryButton)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        addErrorLabelContstraint()
        addRetryButtonConstraint()
    }
    
    @objc func buttonAction(_ sender:UIButton!) {
        Task {await viewModel.getStoreDetails()}
    }
    
    private func addErrorLabelContstraint() {
        let errorLabelTop = NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: view.frame.height * 0.5)

        let errorLabelLeading = NSLayoutConstraint(item: errorLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)

        let errorLabelTrailing = NSLayoutConstraint(item: errorLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        
        view.addConstraints([errorLabelTop, errorLabelLeading, errorLabelTrailing])
    }
    
    private func addRetryButtonConstraint() {
        let retryButtonTop = NSLayoutConstraint(item: retryButton, attribute: .top, relatedBy: .equal, toItem: errorLabel, attribute: .bottom, multiplier: 1, constant: 10)

        let retryButtonLeading = NSLayoutConstraint(item: retryButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 150)

        let retryButtonTrailing = NSLayoutConstraint(item: retryButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -150)
        
        let retryButtonHeight = NSLayoutConstraint(item: retryButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        view.addConstraints([retryButtonTop, retryButtonLeading, retryButtonTrailing, retryButtonHeight])
    }
}
