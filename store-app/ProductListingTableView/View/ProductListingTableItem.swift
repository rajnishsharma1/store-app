//
//  ProductListingTableItem.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingTableItem : UITableViewCell {
    /// Cell identifer
    static let identifer = "ProductListingTableItem"
    
    // MARK: - UI Elemets
    let itemImage: UIImageView = UIImageView()
    let itemName: UILabel = UILabel()
    let itemPrice: UILabel = UILabel()
    let extra: UILabel = UILabel()
    let mrpPlaceHolder: UILabel = UILabel()
    let divider: UIView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        // Visual properties of itemImage
        itemImage.layer.cornerRadius = 8
        
        // Visual properties of itemName
        itemName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        itemName.textColor = UIColor(named: Strings.itemColor)
        
        contentView.backgroundColor = UIColor(named: Strings.tableBackgroundColor)
        
        // Visual properties of extra
        itemPrice.font = UIFont.systemFont(ofSize: 14)
        itemPrice.textColor = UIColor(named: Strings.priceColor)
        
        // Visual properties of itemPrice
        extra.font = UIFont.systemFont(ofSize: 12)
        extra.textColor = UIColor(named: Strings.extraColor)
        
        // Visual properties for placeholder
        mrpPlaceHolder.text = Strings.mrp
        mrpPlaceHolder.font = UIFont.systemFont(ofSize: 14)
        mrpPlaceHolder.textColor = UIColor(named: Strings.mrpPlaceholderColor)
        
        divider.backgroundColor = UIColor(named: Strings.dividerColor)
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extra.translatesAutoresizingMaskIntoConstraints = false
        mrpPlaceHolder.translatesAutoresizingMaskIntoConstraints = false
        divider.translatesAutoresizingMaskIntoConstraints = false

        // Adding views to subview
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(extra)
        contentView.addSubview(mrpPlaceHolder)
        contentView.addSubview(divider)
        
        // Adding constraints for UI Elements
        addImageConstraints()
        addItemNameContstraints()
        addItemPriceConstraints()
        addMrpPlaceholderConstraints()
        addExtraItemDetailsConstraints()
        addDividerConstraint()
    }
    
    // MARK: - Constraints for Item Image
    /// Constraints for ItemImage
    private func addImageConstraints() {
        let imageTop = NSLayoutConstraint(item: itemImage, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 20)
        
        let imageLeading = NSLayoutConstraint(item: itemImage, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 34)
        
        let imageHeight = NSLayoutConstraint(item: itemImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        let imageWidth = NSLayoutConstraint(item: itemImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        contentView.addConstraints([imageTop, imageLeading, imageHeight, imageWidth])
    }
    
    // MARK: - Constraints for Item Name
    /// Constraints for ItemName
    private func addItemNameContstraints() {
        
        let itemNameLeading = NSLayoutConstraint(item: itemName, attribute: .leading, relatedBy: .equal, toItem: itemImage, attribute: .trailing, multiplier: 1, constant: 16)
        
        let itemNameTop = NSLayoutConstraint(item: itemName, attribute: .top, relatedBy: .equal, toItem: itemImage, attribute: .top, multiplier: 1, constant: 0)
        
        contentView.addConstraints([itemNameLeading, itemNameTop])
    }
    
    // MARK: - Constraints for MRP Placeholder
    /// Constraints for MRP Placeholder
    private func addMrpPlaceholderConstraints() {
        let mrpPlaceholderTop = NSLayoutConstraint(item: mrpPlaceHolder, attribute: .top, relatedBy: .equal, toItem: itemName, attribute: .bottom, multiplier: 1, constant: 8)
        
        let mrpPlaceholderLeading = NSLayoutConstraint(item: mrpPlaceHolder, attribute: .leading, relatedBy: .equal, toItem: itemImage, attribute: .trailing, multiplier: 1, constant: 16)
        
        contentView.addConstraints([mrpPlaceholderTop, mrpPlaceholderLeading])
    }
    
    // MARK: - Constraints for Item Price
    /// Constraints for ItemPrice
    private func addItemPriceConstraints() {
        let itemPriceTop = NSLayoutConstraint(item: itemPrice, attribute: .top, relatedBy: .equal, toItem: mrpPlaceHolder, attribute: .top, multiplier: 1, constant: 0)
        
        let itemPriceLeading = NSLayoutConstraint(item: itemPrice, attribute: .leading, relatedBy: .equal, toItem: mrpPlaceHolder, attribute: .trailing, multiplier: 1, constant: 0)
        
        contentView.addConstraints([itemPriceTop, itemPriceLeading])
    }
    
    // MARK: - Constraints for Item Details
    /// Constraints for ItemDetails
    private func addExtraItemDetailsConstraints() {
        let extraTrailing = NSLayoutConstraint(item: extra, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -42)
        
        let extraTop = NSLayoutConstraint(item: extra, attribute: .top, relatedBy: .equal, toItem: itemPrice, attribute: .top, multiplier: 1, constant: 0)
        
        let extraBottom = NSLayoutConstraint(item: extra, attribute: .bottom, relatedBy: .equal, toItem: itemPrice, attribute: .bottom, multiplier: 1, constant: 0)
        
        contentView.addConstraints([extraTrailing, extraBottom, extraTop])
    }
    
    // MARK: - Constraints for Divider
    /// Constraints for Divider
    private func addDividerConstraint() {
        let dividerLeading = NSLayoutConstraint(item: divider, attribute: .leading, relatedBy: .equal, toItem: itemImage, attribute: .trailing, multiplier: 1, constant: 16)
        
        let dividerTop = NSLayoutConstraint(item: divider, attribute: .top, relatedBy: .equal, toItem: mrpPlaceHolder, attribute: .bottom, multiplier: 1, constant: 10)
        
        let dividerTrailing = NSLayoutConstraint(item: divider, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailing, multiplier: 1, constant: -34)
        
        let dividerBottom = NSLayoutConstraint(item: divider, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0)

        let dividerHeight = NSLayoutConstraint(item: divider, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)
        
        contentView.addConstraints([dividerLeading, dividerTop, dividerTrailing, dividerHeight, dividerBottom])
    }
}
