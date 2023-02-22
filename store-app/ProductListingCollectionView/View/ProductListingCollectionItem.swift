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
        itemName.textColor = UIColor(named: Strings.itemColor)
        
        contentView.backgroundColor = UIColor(named: Strings.tableBackgroundColor)
        
        // Visual properties of extra
        itemPrice.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        itemPrice.textColor = UIColor(named: Strings.priceColor)
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false

        // Adding views to subview
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        
        // Adding constraints for UI Elements
        addImageConstraints()
        addItemNameConstraints()
        addItemPriceConstraints()
    }
    
    // MARK: - Constraints for Item Image
    /// Constraints for ItemImage
    private func addImageConstraints() {
        let imageTop = NSLayoutConstraint(item: itemImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        
        let imageLeading = NSLayoutConstraint(item: itemImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 32)
        
        let imageHeight = NSLayoutConstraint(item: itemImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        
        let imageWidth = NSLayoutConstraint(item: itemImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)
        
        contentView.addConstraints([imageTop, imageLeading, imageHeight, imageWidth])
    }
    
    // MARK: - Constraints for Item Name
    /// Constraints for ItemName
    private func addItemNameConstraints() {
        let itemNameTop = NSLayoutConstraint(item: itemName, attribute: .top, relatedBy: .equal, toItem: itemImage, attribute: .bottom, multiplier: 1, constant: 8)
        
        let itemNameStart = NSLayoutConstraint(item: itemName, attribute: .leading, relatedBy: .equal, toItem: itemImage, attribute: .leading, multiplier: 1, constant: 0)
        
        contentView.addConstraints([itemNameTop, itemNameStart])
    }
    
    // MARK: - Constraints for Item Price
    /// Constraints for ItemPrice
    private func addItemPriceConstraints() {
        let itemPriceTop = NSLayoutConstraint(item: itemPrice, attribute: .top, relatedBy: .equal, toItem: itemName, attribute: .bottom, multiplier: 1, constant: 5)
        
        let itemPriceStart = NSLayoutConstraint(item: itemPrice, attribute: .leading, relatedBy: .equal, toItem: itemName, attribute: .leading, multiplier: 1, constant: 0)
        
        contentView.addConstraints([itemPriceTop, itemPriceStart])
    }
}
