//
//  SubscribeResult.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

enum SubscribeResult<Value> {
    case Success(Value)
    case Failure(Error)
}
