//
//  TableDetailsViewController.swift
//  store-app
//
//  Created by Rajnish Sharma on 02/03/23.
//

import UIKit

class ItemDetailsViewController: UIViewController {
    
    // MARK: - Properties
    var itemDetails: ItemModel?
    var isDismisable: Bool = false
    
    // MARK: - Constructor
    init(itemDetails: ItemModel?, isDismissable: Bool = false) {
        self.itemDetails = itemDetails
        self.isDismisable = isDismissable
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UI Elements
    private let itemImage: UIImageView = UIImageView()
    private let itemName: UILabel = UILabel()
    private let itemPrice: UILabel = UILabel()
    private let extra: UILabel = UILabel()
    private let cancelButton: UIImageView = UIImageView()
    
    // MARK: - Image Aspect Ratio
    private var imageAspectRatio: CGFloat = 0.0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        imageAspectRatio = (itemImage.image?.getWidth ?? 0) / (itemImage.image?.getHeight ?? 0)
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        extra.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false

        // Adding views to subview
        view.addSubview(itemImage)
        view.addSubview(itemName)
        view.addSubview(itemPrice)
        view.addSubview(extra)
        view.addSubview(cancelButton)
        
        // Adding constraints for UI Elements
        addImageConstraints()
        addItemNameConstraints()
        addItemPriceConstraints()
        addExtraConstraints()
        addCloseButtonConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Visual properties of itemImage
        itemImage.setCustomImage(itemDetails?.image ?? "")
        itemImage.layer.cornerRadius = 8
        
        // Visual properties of itemName
        itemName.text = itemDetails?.name ?? ""
        itemName.font = UIFont.systemFont(ofSize: 14)
        itemName.textColor = UIColor(named: Strings.itemColor)
        
        view.backgroundColor = UIColor(named: Strings.collectionBackgroundColor)
        
        // Visual properties of extra
        itemPrice.text = itemDetails?.price ?? ""
        itemPrice.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        itemPrice.textColor = UIColor(named: Strings.priceColor)
        
        extra.text = itemDetails?.extra ?? ""
        
        cancelButton.image = UIImage(systemName: "xmark.circle.fill")
        cancelButton.tintColor = .lightGray
        cancelButton.isUserInteractionEnabled = true
        let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.dismissVC))
        cancelButton.addGestureRecognizer(labelTapGesture)
        
        cancelButton.isHidden = !isDismisable

    }
    
    @objc private func dismissVC(sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Constraints for Item Image
    /// Constraints for ItemImage
    private func addImageConstraints() {
        let imageTop = NSLayoutConstraint(item: itemImage, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: isDismisable ? 76 : 100)
        
        let imageLeading = NSLayoutConstraint(item: itemImage, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        
        let imageTrailing = NSLayoutConstraint(item: itemImage, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        
        let imageHeight = NSLayoutConstraint(item: itemImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (view.bounds.width - 40) / imageAspectRatio)
        
        view.addConstraints([imageTop, imageLeading, imageTrailing, imageHeight])
    }
    
    // MARK: - Constraints for Item Name
    /// Constraints for ItemName
    private func addItemNameConstraints() {
        let itemNameTop = NSLayoutConstraint(item: itemName, attribute: .top, relatedBy: .equal, toItem: itemImage, attribute: .bottom, multiplier: 1, constant: 8)
        
        let itemNameStart = NSLayoutConstraint(item: itemName, attribute: .leading, relatedBy: .equal, toItem: itemImage, attribute: .leading, multiplier: 1, constant: 0)
        
        view.addConstraints([itemNameTop, itemNameStart])
    }
    
    // MARK: - Constraints for Item Price
    /// Constraints for ItemPrice
    private func addItemPriceConstraints() {
        let itemPriceTop = NSLayoutConstraint(item: itemPrice, attribute: .top, relatedBy: .equal, toItem: itemName, attribute: .bottom, multiplier: 1, constant: 5)
        
        let itemPriceStart = NSLayoutConstraint(item: itemPrice, attribute: .leading, relatedBy: .equal, toItem: itemName, attribute: .leading, multiplier: 1, constant: 0)
        
        view.addConstraints([itemPriceTop, itemPriceStart])
    }
    
    private func addExtraConstraints() {
        let extraTop = NSLayoutConstraint(item: extra, attribute: .top, relatedBy: .equal, toItem: itemPrice, attribute: .bottom, multiplier: 1, constant: 5)
        
        let extraStart = NSLayoutConstraint(item: extra, attribute: .leading, relatedBy: .equal, toItem: itemPrice, attribute: .leading, multiplier: 1, constant: 0)
        
        view.addConstraints([extraTop, extraStart])
    }
    
    // MARK: - Constraints for Close Button
    /// Constraints for Close Button
    private func addCloseButtonConstraints() {
        let cancelButtonTop = NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 20)
        
        let cancelButtonTrailing = NSLayoutConstraint(item: cancelButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
        
        let cancelButtonWidth = NSLayoutConstraint(item: cancelButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        let cancelButtonHeight = NSLayoutConstraint(item: cancelButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
    
        
        view.addConstraints([cancelButtonTop, cancelButtonTrailing, cancelButtonWidth, cancelButtonHeight])
    }
}
