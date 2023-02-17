//
//  AppUtils.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

class AppUtils {
    static func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
}

extension UIImageView {
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "store_default.png")
            return
        }
        if (imageURLString.isEmpty) {
            self.image = UIImage(named: "store_default.png")
        } else {
            DispatchQueue.global().async { [weak self] in
                let data = try? Data(contentsOf: URL(string: imageURLString)!)
                DispatchQueue.main.async {
                    self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "store_default.png")
                }
            }
        }
        
    }
}

