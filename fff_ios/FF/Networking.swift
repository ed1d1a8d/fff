//
//  Networking.swift
//  FF
//
//  Created by Jing Lin on 8/29/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import Foundation

struct endpoints {
    struct musicu {
        static let base = "https://mus.icu"
        static let auth = "\(base)/auth/registration"
    }
}

enum HTTPMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

class HTTPAPI {
    
    var request:URLRequest!
    var session:URLSession!
    var configuration:URLSessionConfiguration
    
    private init() {
        self.configuration = URLSessionConfiguration.default
        self.configuration.timeoutIntervalForRequest = 30
        self.configuration.timeoutIntervalForResource = 30
    }
    
    static func instance() -> HTTPAPI {
        return HTTPAPI()
    }
    
    func call(url: String, params: Dictionary<String, Any>?, method: HTTPMethod, success:@escaping (Data?, HTTPURLResponse?, NSError?) -> Void, failure:@escaping (Data?, HTTPURLResponse?, NSError?) -> Void) {
        self.request = URLRequest(url: URL(string: url)!)
        
        if let params = params {
            let jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        }
        request.httpMethod = method.rawValue
        
        session = URLSession(configuration: self.configuration)
        session.dataTask(with: request) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data, response, error as NSError?)
                } else {
                    failure(data, response as? HTTPURLResponse, error as NSError?)
                }
            } else {
                failure(data, response as? HTTPURLResponse, error as NSError?)
            }
        }.resume()
    }

}

