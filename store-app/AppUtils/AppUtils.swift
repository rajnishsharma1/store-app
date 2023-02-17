//
//  AppUtils.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: Strings.placeholderImage)
            return
        }
        if (imageURLString.isEmpty) {
            self.image = UIImage(named: Strings.placeholderImage)
        } else {
            DispatchQueue.global().async { [weak self] in
                let data = try? Data(contentsOf: URL(string: imageURLString)!)
                DispatchQueue.main.async {
                    self?.image = data != nil ? UIImage(data: data!) : UIImage(named: Strings.placeholderImage)
                }
            }
        }
        
    }
}

