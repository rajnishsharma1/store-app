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
    func setCustomImage(_ urlString: String) {
        let placeHolderImage: UIImage = UIImage(named: Strings.placeholderImage)!
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = placeHolderImage
                }
            }

            guard let data = data else { return }
            let image = UIImage(data: data)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}


extension UIImage {
    var getWidth: CGFloat {
        get {
            let width = self.size.width
            return width
        }
    }
    
    var getHeight: CGFloat {
        get {
            let height = self.size.height
            return height
        }
    }
}
