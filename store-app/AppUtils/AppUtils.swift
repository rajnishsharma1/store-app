//
//  AppUtils.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

// MARK: - Extensions for UIImageView

var imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    // MARK: Setting image to UIImageView
    func setCustomImage(_ urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else {
            let placeHolderImage: UIImage = UIImage(named: Strings.placeholderImage)!
            self.image = placeHolderImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                 if let error = error {
                     print("Couldn't download image: ", error)
                     return
                 }
                 
                 guard let data = data else { return }
                 let image = UIImage(data: data)
                 imageCache.setObject(image!, forKey: urlString as AnyObject)
                 
                 DispatchQueue.main.async {
                     self.image = image
                 }
             }.resume()
    }
}
