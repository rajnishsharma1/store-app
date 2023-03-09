//
//  MenuViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 06/03/23.
//

import UIKit

class MenuViewController: UIViewController {
    
    /// Delegate for Menu Button
    var menuButtonDelegate: SideMenuDelegate? = nil
    
    /// Close button
    let closeButton = UIButton(type: .close)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        setupCloseButton()
        setupCloseConstraints()
    }
    
    // Setup Close Button
    func setupCloseButton() {

        closeButton.backgroundColor = .white
        closeButton.layer.cornerRadius = 14
        
        // Setup the Tap Gesture Recognizer.
        closeButton.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onCloseTap))
        closeButton.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // Constraints for the close button
    func setupCloseConstraints() {
        let closeTop = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
        let closeLeading = NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        
        self.view.addConstraints([closeTop, closeLeading])
    }
    
    // Close Button listener
    @objc func onCloseTap() {
        self.menuButtonDelegate?.menuButtonTapped()
    }
}
