//
//  GithubAPI.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import Moya

enum GithubAPI {
    case getUserList(name: String)
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else {
            fatalError("")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getUserList:
            return "/search/users"
        }
    }
    
    var method: Method {
        switch self {
        case .getUserList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUserList(let value):
            let params = [
                "q": value
            ]
            
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getUserList:
            return ["Content-type": "application/json"]
        }
    }
    
    
}
