//
//  ImageLoaderViewModel.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import Foundation

class ImageLoaderViewModel: ObservableObject {

    @Published var imageData = Data()
    @Published var loading = false

    private var useCase: ImageLoaderUseCaseProtocol

    init(useCase: ImageLoaderUseCaseProtocol = ImageLoaderUseCase()) {
        self.useCase = useCase
    }

    func loadImage(from url: String, size: ImageSize, fileExtension: ImageExtension) {
        loading = true
        useCase.loadImage(from: url, size: size, fileExtension: fileExtension) { result in
            self.loading = false
            switch result {
            case .success(let data): self.imageData = data
            default: break
            }
        }
    }

}
