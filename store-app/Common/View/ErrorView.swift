//
//  ErrorView.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation

import UIKit

class ErrorView: UIView {
    /// UI Element
    private var errorLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        errorLabel = UILabel(frame: frame)
        errorLabel.textAlignment = .center
        errorLabel.textColor = .gray
        errorLabel.font = UIFont.systemFont(ofSize: 18)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Show Error on UIViewController
    func showError(view: UIView, errorText: String) {
        errorLabel.text = errorText
        view.addSubview(errorLabel)
    }
    
    /// Hide Error from UIViewController
    func hideError(view: UIView) {
        errorLabel.removeFromSuperview()
    }
}
