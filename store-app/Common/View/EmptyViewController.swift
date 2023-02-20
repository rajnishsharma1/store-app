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
        
        emptyLabel.text = "Empty View"
        emptyLabel.frame = view.frame
        emptyLabel.textAlignment = .center
        emptyLabel.textColor = .gray
        emptyLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(emptyLabel)
    }
}
