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
        
        // Visual properties of extra
        itemPrice.font = UIFont.systemFont(ofSize: 14)
        
        // Visual properties of itemPrice
        extra.font = UIFont.systemFont(ofSize: 12)
        extra.textColor = .gray
        
        // Visual properties for placeholder
        mrpPlaceHolder.text = Strings.mrp
        mrpPlaceHolder.font = UIFont.systemFont(ofSize: 14)
        mrpPlaceHolder.textColor = .gray
        
        divider.backgroundColor = UIColor(named: Strings.divider)
        
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

        // Mappding views to string to set the constraints
        let viewsDict = [
            "storeImage" : itemImage,
            "itemName" : itemName,
            "itemPrice" : itemPrice,
            "extra" : extra,
            "mrpPlaceHolder": mrpPlaceHolder,
            "divider": divider
        ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[storeImage(50)]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[extra]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[itemPrice]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mrpPlaceHolder]-10-[divider(0.5)]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[itemPrice]-10-[divider(0.5)]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[mrpPlaceHolder]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-[itemName]|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-[mrpPlaceHolder]-[itemPrice]-[extra]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[storeImage(50)]-[divider]-16-|", options: [], metrics: nil, views: viewsDict))
    }
}
