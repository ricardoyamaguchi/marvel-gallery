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
    
    func fetchStandardSmallImage(from path: String, type: ImageType, completion: @escaping ImageCallback) {
        fetchImage(from: path, size: .standardSmall, type: type) { data in
            completion(data)
        }
    }

    func fetchStandardMediumImage(from path: String, type: ImageType, completion: @escaping ImageCallback) {
        fetchImage(from: path, size: .standardMedium, type: type) { data in
            completion(data)
        }
    }

    func fetchStandardXlargeImage(from path: String, type: ImageType, completion: @escaping ImageCallback) {
        fetchImage(from: path, size: .standardXlarge, type: type) { data in
            completion(data)
        }
    }

    func fetchStandardFantasticImage(from path: String, type: ImageType, completion: @escaping ImageCallback) {
        fetchImage(from: path, size: .standardFantastic, type: type) { data in
            completion(data)
        }
    }
    
    private func fetchImage(from path: String, size: ImageSize, type: ImageType, callback: @escaping ImageCallback) {
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
