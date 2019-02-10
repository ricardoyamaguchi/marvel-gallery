//
//  BaseProvider.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 04/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation
import Alamofire

typealias ProviderCallback<T> = (([T]?) -> Void)

class BaseProvider<T: Codable> {
    
    var endPoint: String { return "" }
    
    static var header: [String: String] {
        return ["apikey": "0e3b7a907ce8ed9f13a5264d066221c6",
                "hash": "d614f88508c79b7ba91d1a1201d0bba1",
                "ts": "1"]
    }
    
    func get(completion: @escaping ProviderCallback<T>) {
        Alamofire.request("\(Constants.BaseURL)\(endPoint)").responseJSON { response in
            if let data = response.data {
                let marvelResponse = try? JSONDecoder().decode(MarvelResponse<T>.self, from: data)
                completion(marvelResponse?.data.results)
            }
        }
    }
    
}
