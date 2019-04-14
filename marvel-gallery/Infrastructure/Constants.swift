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
    case standardXlarge = "standard_xlarge"
    case standardFantastic = "standard_fantastic"
    case standardUncanny = "standard_uncanny"
    case standardIncredible = "standard_incredible"
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXlarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
    case landscapeSmall = "landscape_small"
    case landscapeMedium = "landscape_medium"
    case landscapeXlarge = "landscape_xlarge"
    case landscapeFantastic = "landscape_fantastic"
    case landscapeUncanny = "landscape_uncanny"
    case landscapeIncredible = "landscape_incredible"
    
}

enum ImageType: String, Codable {
    
    case jpg
    case svg
    case jpeg
    case png
    case gif

}
