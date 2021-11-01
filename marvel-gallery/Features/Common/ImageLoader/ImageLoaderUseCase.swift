//
//  ImageLoaderUseCase.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import Foundation

protocol ImageLoaderUseCaseProtocol {
    func loadImage(from url: String, size: ImageSize, fileExtension: ImageExtension,
                   completion: @escaping DataCompletion)
}

class ImageLoaderUseCase: ImageLoaderUseCaseProtocol {

    private var service: ImageLoaderServiceProtocol

    init(service: ImageLoaderServiceProtocol = ImageLoaderService()) {
        self.service = service
    }

    func loadImage(from url: String, size: ImageSize, fileExtension: ImageExtension,
                   completion: @escaping DataCompletion) {
        let urlString = "\(url)/\(size.rawValue).\(fileExtension.rawValue)"
        service.loadImage(for: urlString, completion: completion)
    }
}
