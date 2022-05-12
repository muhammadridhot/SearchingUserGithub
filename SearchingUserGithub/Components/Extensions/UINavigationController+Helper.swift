//
//  UINavigationController+Helper.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

extension UINavigationController {
    func getControllerFromNavigationStack<T>(type: T.Type) -> T? where T: UIViewController {
        return viewControllers.filter { (vc) -> Bool in
            vc is T
        }.first as? T
    }
}
