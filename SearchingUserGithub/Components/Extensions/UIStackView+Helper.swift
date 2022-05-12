//
//  UIStackView+Helper.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
