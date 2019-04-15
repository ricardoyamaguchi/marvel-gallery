//
//  Constants.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 03/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation

struct Http {
    static let BaseURL = "https://gateway.marvel.com:443"
}

enum ImageSize: String {
    
    case standardSmall = "standard_small"
    case standardMedium = "standard_medium"
    case standardLarge = "standard_large"
    case standardXlarge = "standard_xlarge"
    case standardFantastic = "standard_fantastic"
    case standardAmazing = "standard_amazing"
    case standardIncredible = "standard_incredible"
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitLarge = "portrait_large"
    case portraitXlarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeLarge = "landscape_large"
    case landscapeXlarge = "landscape_xlarge"
    case landscapeFantastic = "landscape_fantastic"
    case landscapeAmazing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"
    
}

enum ImageType: String, Codable {
    
    case jpg
    case svg
    case jpeg
    case png
    case gif

}
