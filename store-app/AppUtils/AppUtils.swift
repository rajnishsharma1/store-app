//
//  AppUtils.swift
//  store-app
//
//  Created by Rajnish Sharma on 16/02/23.
//

import Foundation
import UIKit

class AppUtils {
    static func hexStringToUIColor (hex: String, alpha: Double) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var red: Double = 0.0
        var green: Double = 0.0
        var blue: Double = 0.0
        var opacity: Double = alpha

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return UIColor.gray }

            if length == 6 {
                red = Double((rgb & 0xFF0000) >> 16) / 255.0
                green = Double((rgb & 0x00FF00) >> 8) / 255.0
                blue = Double(rgb & 0x0000FF) / 255.0

            } else if length == 8 {
                red = Double((rgb & 0xFF000000) >> 24) / 255.0
                green = Double((rgb & 0x00FF0000) >> 16) / 255.0
                blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
                opacity = Double(rgb & 0x000000FF) / 255.0

            } else {
                return UIColor.gray
            }

            return UIColor(red: red, green: green, blue: blue, alpha: opacity)
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

