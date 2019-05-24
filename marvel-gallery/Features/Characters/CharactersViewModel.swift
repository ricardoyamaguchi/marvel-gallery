//
//  CharactersViewModel.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 13/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

typealias DownloadCompletion = (String, Data) -> Void

class CharactersViewModel {
    
    private var charactersProvider = CharactersProvider()
    private var imageProvider = ImageProvider()
    private var cachedDataImages: [String: Data] = [:]
    
    var data = Dynamic<[Character]>([])
    var total = 0
    var characters: [Character] {
        return data.value
    }
    
    func fetchCharacters(name: String = "") {
        var value = self.data.value
        charactersProvider.getList(startsWith: name, offset: data.value.count) { [weak self] response in
            guard let results = response?.results, let total = response?.total  else { return }
            value.append(contentsOf: results)
            self?.total = total
            self?.data.value = value
        }
    }
    
    func fetchImage(index: Int, completion: @escaping DownloadCompletion) {
        guard let thumbnail = characters[index].thumbnail, let path = thumbnail.path else { return }
        if let data = cachedDataImages[path] {
            completion(path, data)
        } else {
            imageProvider.fetchStandardFantasticImage(from: path,
                                                  type: thumbnail.type ?? .jpg) { [weak self] imageData in
                                                    guard let data = imageData else { return }
                                                    self?.cachedDataImages[path] = data
                                                    completion(path, data)
            }
        }
    }

}
