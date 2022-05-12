//
//  MoyaResponse+JASON.swift
//  TokopediaMiniProject
//
//  Created by CoffeeLatte on 12/05/22.
//

import RxSwift
import Moya
import JASON

internal extension Response {

    func mapObject<T: Mappable>(withKeyPath keyPath: [Any] = []) -> T? {

        let bodyJSON = createBodyJSON(keyPath: keyPath)

        return T(json: bodyJSON)
    }
    
    // MARK: - Private methods

    private func createBodyJSON(keyPath: [Any]) -> JSON {

        return keyPath.reduce(JSON(data)) { json, currentKeypath in

            return json[path: currentKeypath]
        }
    }
}

// This class is for mapping the moya response that you don't really need its value
class VoidClass: Mappable {
    required init?(json: JSON) {}
}

/// Extension for processing Responses into Mappable objects through ObjectMapper
internal extension ObservableType where Element == Response {
    
    // Maps data received from the Observable into an object (on the default Background thread) which
    /// Implements the Mappable protocol and returns the result back on the MainScheduler.
    /// If the conversion fails, the Observable will send an Error event.
    func mapObject<T: Mappable>(type: T.Type, keyPath: [Any] = []) -> Observable<T> {

        return observe(on: SerialDispatchQueueScheduler(qos: .background))
            .flatMap { response -> Observable<T> in

                if type == VoidClass.self, let voidClass = VoidClass(json: nil) as? T {
                    return Observable.just(voidClass)
                }
                
                let object: T? = response.mapObject(withKeyPath: keyPath)

                if let validObject = object {
                    return Observable.just(validObject)
                }

                var reason = ""
                
                if response.statusCode == 403 {
                    reason = "Exceeded limit of 10 non authenticated requests per minute for GitHub API. Please wait a minute. :(\nhttps://developer.github.com/v3/#rate-limiting"
                } else {
                    reason = "Failed to parse server's response."
                }
                
                let error = NSError(domain: "", code: -1011, userInfo: [ NSLocalizedDescriptionKey: reason ])
                return Observable.error(error)
            }
            .observe(on: MainScheduler.instance)
    }
}
