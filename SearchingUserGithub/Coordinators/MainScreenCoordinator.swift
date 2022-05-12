//
//  MainScreenCoordinator.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    var navigationController: BaseNavigationController = BaseNavigationController()

    var screenStack: [Screenable] = []

    var onCompleted: ((ScreenResult?) -> Void)?

    var currentWindow: UIWindow?

    init(window: UIWindow?) {
        currentWindow = window
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func start() {
        set([GithubListScreen(())])
    }

    func updateTitle() {}

    func showScreen(identifier: String, navigation: Navigation) {
        switch identifier {
        case kGithubListScreen:
            configureGithubListScreenNavigationEvent(navigation)
        default:
            break
        }
    }
    
    private func configureGithubListScreenNavigationEvent(_ navigation: Navigation) {
        switch navigation {
        case .previous:
            break
        case .next(let value):
            if let result = value as? String {
                if result == kGithubListScreen {
                    push(GithubListScreen(()))
                }
            }
        }
    }
}

