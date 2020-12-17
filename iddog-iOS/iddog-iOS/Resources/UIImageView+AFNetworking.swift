//
//  UIImageView+AFNetworking.swift
//  iddog-iOS
//
//  Created by João Vitor Lopes Capi on 17/12/20.
//

import UIKit

extension UIImageView {
    
    //auxiliary method to load image from URL
    public func insertImageFromUrl(urlAsString: String) {
        if let url = URL(string: urlAsString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: {
                (data, response , error) in
                
                guard error == nil else { print(error!); return }
                
                if let data = data {
                    self.image = UIImage(data: data)
                }
            })
            task.resume()
        }
        
    }
}
