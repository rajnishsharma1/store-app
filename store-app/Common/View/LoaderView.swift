//
//  LoaderView.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class LoaderView: UIView {
    private var loader: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loader = UIActivityIndicatorView(frame: frame)
        loader.style = .large

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoader(view: UIView) {
        loader.startAnimating()
        view.addSubview(loader)
    }
    
    func hideLoader(view: UIView) {
        loader.stopAnimating()
        loader.removeFromSuperview()
    }
}
