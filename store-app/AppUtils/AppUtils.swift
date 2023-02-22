//
//  AppUtils.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

// MARK: - Extensions for UIImageView
extension UIImageView {
    
    // MARK: Setting image to UIImageView
    func setCustomImage(_ imgURLString: String?) {
        let placeHolderImage: UIImage = UIImage(named: Strings.placeholderImage)!
        guard let imageURLString = imgURLString else {
            self.image = placeHolderImage
            return
        }
        if (imageURLString.isEmpty) {
            self.image = placeHolderImage
        } else {
            DispatchQueue.global().async { [weak self] in
                let data = try? Data(contentsOf: URL(string: imageURLString)!)
                DispatchQueue.main.async {
                    self?.image = data != nil ? UIImage(data: data!) : placeHolderImage
                }
            }
        }
        
    }
}
