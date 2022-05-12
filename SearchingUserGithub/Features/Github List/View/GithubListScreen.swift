//
//  GithubListScreen.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

let kGithubListScreen = "Github List Screen"

final class GithubListScreen: Screen<Void> {
    
    override var identifier: String {
        return kGithubListScreen
    }
    
    override func build() -> ViewController {
        
        let viewModel = GithubListViewModel()
        let viewController = GithubListViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on { [weak self] navigation in
            self?.event?(navigation)
        }
        
        return viewController
    }
    
}

