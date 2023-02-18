//
//  ProductListingTableItem.swift
//  store-app
//
//  Created by Rajnish Sharma on 15/02/23.
//

import Foundation
import UIKit

class ProductListingTableItem : UITableViewCell {
    static let identifer = "ProductListingTableItem"
    
    let itemImage: UIImageView = UIImageView()
    let itemName: UILabel = UILabel()
    let itemPrice: UILabel = UILabel()
    let extra: UILabel = UILabel()
    let mrpPlaceHolder: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
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
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extra.translatesAutoresizingMaskIntoConstraints = false
        mrpPlaceHolder.translatesAutoresizingMaskIntoConstraints = false

        // Adding views to subview
        contentView.addSubview(itemImage)
        contentView.addSubview(itemName)
        contentView.addSubview(itemPrice)
        contentView.addSubview(extra)
        contentView.addSubview(mrpPlaceHolder)

        // Mappding views to string to set the constraints
        let viewsDict = [
            "storeImage" : itemImage,
            "itemName" : itemName,
            "itemPrice" : itemPrice,
            "extra" : extra,
            "mrpPlaceHolder": mrpPlaceHolder
        ] as [String : Any]

        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[storeImage(50)]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-40-[extra]", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[itemPrice]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemName]-[mrpPlaceHolder]-|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-[itemName]|", options: [], metrics: nil, views: viewsDict))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[storeImage(50)]-[mrpPlaceHolder]-[itemPrice]-[extra]-|", options: [], metrics: nil, views: viewsDict))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
