//
//  GithubUserListModel.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import JASON

struct GithubUserListModel: Mappable {
    let items: [GithubUserModel]
    
    init?(json: JSON) {
        guard let items = json["items"].jsonArray else {
            print("INI DIA")
            return nil
        }
        
        self.items = items.compactMap { (json: JSON) -> GithubUserModel? in
            return GithubUserModel(json: json)
        }
    }
}

struct GithubUserModel: Mappable {
    let login: String
    let avatarURL: String
    
    init?(json: JSON) {
        guard let login = json["login"].string,
        let avatarURL = json["avatar_url"].string else {
            return nil
        }
        self.login = login
        self.avatarURL = avatarURL
    }
}
