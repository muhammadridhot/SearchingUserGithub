//
//  GithubListViewModel.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import RxSwift
import RxCocoa

class GithubListViewModel {
    
    var userList: [GithubUserModel] = []
    
    private let service =  GithubService()
    private let disposeBag = DisposeBag()
    
    let userListSubject = PublishSubject<SubscribeResult<GithubUserListModel>>()
    
    func getUserList(name: String) {
        service.getUserList(name: name)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] response in
                    self?.userList = response.items
                    self?.userListSubject.onNext(.Success(response))
                }, onError: { [weak self] error in
                    self?.userListSubject.onNext(.Failure(error))
                })
            .disposed(by: disposeBag)
    }
}
