//
//  ProductListingCollectionItem.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit
import MetricKit

class ProductListingCollectionItem: UICollectionViewCell {
    /// Cell identifer
    static let identifer = "ProductListingCollectionItem"
    
    // MARK: - UI Elemets
    let itemImage: UIImageView = UIImageView()
    let itemName: UILabel = UILabel()
    let itemPrice: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        // Visual properties of itemImage
        itemImage.layer.cornerRadius = 8
        
        // Visual properties of itemName
        itemName.font = UIFont.systemFont(ofSize: 14)
        
        // Visual properties of extra
        itemPrice.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false

        // Adding views to subview
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)

        // Mappding views to string to set the constraints
        let viewsDict = [
            "storeImage" : itemImage,
            "itemName" : itemName,
            "itemPrice" : itemPrice,
        ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[storeImage(80)]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[storeImage(80)]-[itemName]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[itemName]-5-[itemPrice]", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[storeImage(80)]", options: [], metrics: nil, views: viewsDict))
    }
}
