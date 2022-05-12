//
//  Mappable.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import JASON

internal protocol Mappable {

    init?(json: JSON)

    func toDictionary() -> [String: Any]
}

extension Mappable {

    func toDictionary() -> [String: Any] {
        return [:]
    }

}
