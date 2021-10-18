//
//  ImageLoaderService.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import Foundation

protocol ImageLoaderServiceProtocol {

    func loadImage(for url: String, completion: @escaping DataCompletion)

}

class ImageLoaderService: BaseService, ImageLoaderServiceProtocol {

    private let cache = NSCache<NSString, NSData>()

    func loadImage(for url: String, completion: @escaping DataCompletion) {
        if let cachedData = cache.object(forKey: (url as NSString)) as Data? {
            completion(.success(cachedData))
            return
        }
        connection.request(urlString: url) { [weak self] result in
            switch result {
            case .success(let data): self?.cache.setObject((data as NSData), forKey: (url as NSString))
            default: break
            }
            completion(result)
        }
    }

}

enum ImageSize: String {

    // MARK: - Portrait sizes

    /**
      Portrait Smal - size: 50x75px
     */
    case portraitSmall = "portrait_small"

    /**
      Portrait Medium - size: 100x150px
     */
    case portraitMedium = "portrait_medium"

    /**
      Portrait XLarge - size: 150x225px
     */
    case portraitXLarge = "portrait_xlarge"

    /**
      Portrait Fantastic - size: 168x252px
     */
    case portraitFantastic = "portrait_fantastic"

    /**
      Portrait Uncanny - size: 300x450px
     */
    case portraitUncanny = "portrait_uncanny"

    /**
      Portrait Incredible - size: 216x324px
     */
    case portraitIncredible = "portrait_incredible"

    // MARK: - Standard sizes

    /**
      Standard Small - size: 65x45px
     */
    case standardSmall = "standard_small"

    /**
      Standard Medium - size: 100x100px
     */
    case standardMedium = "standard_medium"

    /**
      Standard Large- size: 140x140px
     */
    case standardLarge = "standard_large"

    /**
      Standard XLarge - size: 200x200px
     */
    case standardXLarge = "standard_xlarge"

    /**
      Standard Fantastic - size: 250x250px
     */
    case standardFantastic = "standard_fantastic"

    /**
      Standard Amazing - size: 180x180px
     */
    case standardAmazing = "standard_amazing"

    // MARK: - Landscape sizes

    /**
      Landscape Small - size: 120x90px
     */
    case landscapeSmall = "landscape_small"

    /**
      Landscape Medium - size: 175x130px
     */
    case landscapeMedium = "landscape_medium"

    /**
      Landscape Large - size: 190x140px
     */
    case landscapeLarge = "landscape_large"

    /**
      Landscape XLarge - size: 270x200px
     */
    case landscapeXLarge = "landscape_xlarge"

    /**
      Landscape Amazing - size: 250x156px
     */
    case landscapeAmazing = "landscape_amazing"

    /**
      Landscape Incredible - size: 464x261px
     */
    case landscapeIncredible = "landscape_incredible"

}

enum ImageExtension: String {
    case jpg
    case png
    case gif
}
