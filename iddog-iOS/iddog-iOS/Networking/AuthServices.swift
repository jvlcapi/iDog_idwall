//
//  AuthServices.swift
//  iddog-iOS
//
//  Created by João Vitor Lopes Capi on 17/12/20.
//

import Foundation
import Alamofire

class AuthServices {
    
    static func signUp( email: String,
                        escToken: @escaping (Swift.Result<SignUpToken, APIError>) -> (Void))
    {

        HTTPClient.request(path: "signup", method: .post, parameters: ["email": email] ,encoding: JSONEncoding()) {

            (result: Result<SignUpToken, APIError>) -> (Void) in

            escToken(result)
        }
    }
    
}
