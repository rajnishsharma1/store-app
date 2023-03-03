//
//  MyPopViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 02/03/23.
//

import UIKit

class MyPopViewController: UIViewController {

    let popupBox: UIView = {
          let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .green
           return view
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        self.definesPresentationContext = true

        setupViews()

    }
    
    func setupViews() {
         view.addSubview(popupBox)

         // autolayout constraint for popupBox
            popupBox.heightAnchor.constraint(equalToConstant: 200).isActive = true
            popupBox.widthAnchor.constraint(equalToConstant: 300).isActive = true
            popupBox.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            popupBox.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
