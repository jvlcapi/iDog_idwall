//
//  DogServices.swift
//  iddog-iOS
//
//  Created by João Vitor Lopes Capi on 16/12/20.
//

import Foundation
import Alamofire


class DogServices {
    static func fetchDogs(category: String,
                          tokenKey: String,
                          escDogList: @escaping (Swift.Result<DogList, APIError>) -> (Void)){
        
        HTTPClient.request(path: "feed", method: .get, parameters: ["category": category], encoding: URLEncoding(), headers: [.authorization(bearerToken: tokenKey)]) {
            
            (result: Result<DogList, APIError>) -> (Void) in
            
            escDogList(result)
        }
    }
    
}
