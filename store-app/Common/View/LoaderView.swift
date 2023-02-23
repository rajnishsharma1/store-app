//
//  LoaderView.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class LoaderView: UIView {
    /// UI Element
    private var loader: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(frame: frame)
        loader.style = .large

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        loader.stopAnimating()
    }
    
    /// Show Loader on UIViewController
    func showLoader(view: UIView) {
        loader.startAnimating()
        view.addSubview(loader)
    }
    
    /// Show Loader from UIViewController
    func hideLoader(view: UIView) {
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
}
