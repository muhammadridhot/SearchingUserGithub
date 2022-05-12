//
//  GithubService.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import Moya
import RxSwift
import RxCocoa

final class DelayScheduler: ImmediateSchedulerType {

    init(delay: TimeInterval, queue: DispatchQueue = .main) {
        self.queue = queue
        dispatchDelay = delay
    }

    func schedule<StateType>(_ state: StateType, action: @escaping (StateType) -> Disposable) -> Disposable {
        let cancel = SingleAssignmentDisposable()
        lastDispatch = max(lastDispatch + dispatchDelay, .now())
        queue.asyncAfter(deadline: lastDispatch) {
            guard cancel.isDisposed == false else { return }
            cancel.setDisposable(action(state))
        }
        return cancel
    }

    var lastDispatch: DispatchTime = .now()
    let queue: DispatchQueue
    let dispatchDelay: TimeInterval
}

protocol GithubServiceType {
    func getUserList(name: String) -> Observable<GithubUserListModel>
}

class GithubService: GithubServiceType {
    private let provider = MoyaProvider<GithubAPI>()
    let scheduler = DelayScheduler(delay: 6)
    
    func getUserList(name: String) -> Observable<GithubUserListModel> {
        return provider.rx.request(.getUserList(name: name))
            .asObservable()
            .mapObject(type: GithubUserListModel.self)
    }
}
