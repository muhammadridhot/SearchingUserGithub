//
//  BaseNavigationController.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

internal final class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        let bool = navigationController.viewControllers.count != 1
        navigationController.tabBarController?.tabBar.isHidden = bool
    }

}
