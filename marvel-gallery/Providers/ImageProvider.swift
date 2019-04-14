//
//  ImageProvider.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 06/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

typealias ImageCallback = (Data?) -> Void

class ImageProvider {
    
    static func fetchImage(from path: String, size: ImageSize, type: ImageType, callback: @escaping ImageCallback) {
        guard let url = URL(string: "\(path)/\(size.rawValue).\(type.rawValue)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (responseData, _, _) -> Void in
            if let data = responseData {
                DispatchQueue.main.async {
                    callback(data)
                }
            } else {
                DispatchQueue.main.async {
                    callback(nil)
                }
            }
        }
        task.resume()
    }
    
}
