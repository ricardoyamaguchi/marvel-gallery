//
//  String.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 18/10/21.
//

import Foundation

extension String {

    static func urlImage(for path: String, size: ImageSize, imageExtension: ImageExtension) -> String {
        return "\(path)/\(size.rawValue).\(imageExtension.rawValue)"
    }

}
