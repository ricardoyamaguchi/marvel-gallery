//
//  BaseProvider.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 04/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation
import Alamofire

typealias ProviderCallback<T: Codable> = ((DataClass<T>?) -> Void)

class BaseProvider<T: Codable> {
    
    private let startsWithParam = "StartsWith"
    
    var endPoint: String { return "" }
    var startsWithFieldName: String { return "" }
    
    var parameters: [String: Any] {
        return ["apikey": "0e3b7a907ce8ed9f13a5264d066221c6",
                "hash": "d614f88508c79b7ba91d1a1201d0bba1",
                "ts": "1",
                "offset": 0]
    }
    
    func getList(startsWith: String = "", offset: Int = 0, completion: @escaping ProviderCallback<T>) {
        var parameters = self.parameters
        parameters["offset"] = offset
        if !startsWith.isEmpty {
            parameters["\(startsWithFieldName)\(startsWithParam)"] = startsWith
        }
        request(parameters: parameters, completion: completion)
    }
    
    private func request(parameters: [String: Any], completion: @escaping ProviderCallback<T>) {
        let requestAddress = "\(Http.BaseURL)\(endPoint)"
        Alamofire.request(requestAddress, method: .get, parameters: parameters).responseJSON { response in
            debugPrint(response)
            if let data = response.data {
                do {
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse<T>.self, from: data)
                    completion(marvelResponse.data)
                } catch let error {
                    debugPrint(error)
                }
            }
        }

    }
    
}
