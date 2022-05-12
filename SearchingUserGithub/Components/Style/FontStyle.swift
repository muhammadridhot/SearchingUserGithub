//
//  FontStyle.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

extension UIFont {

    private static func getFont(name: String, size: Double) -> UIFont {

        if let font = UIFont(name: name, size: CGFloat(size)) {
            return font
        }

        return UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func poppinsLightFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-Light", size: size)
    }
    
    class func poppinsRegularFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-Regular", size: size)
    }
    
    class func poppinsMediumFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-Medium", size: size)
    }
    
    class func poppinsSemiBoldFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-SemiBold", size: size)
    }
    
    class func poppinsBoldFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-Bold", size: size)
    }

    class func poppinsItalicFont(size: Double) -> UIFont {
        return getFont(name: "Poppins-Italic", size: size)
    }
    
}
