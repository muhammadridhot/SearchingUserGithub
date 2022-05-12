//
//  ViewController.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

class ViewController: UIViewController {

    let navigationEvent: NavigationEvent = NavigationEvent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func onTapDefaultNavViewBackButton() {
        navigationEvent.send(.previous(nil))
    }

}

