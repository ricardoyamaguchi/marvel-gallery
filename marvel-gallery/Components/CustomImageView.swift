//
//  CustomImageView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 13/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createActivityIndicator()
    }
    
    /// Loads image from specified URL
    ///
    /// - Parameter url: Image URL source to download
    func loadFrom(url: URL, size: ImageSize, imageExtension: ImageType) {
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let finalUrl = URL(string: "\(url.absoluteString)/\(self?.imageSize(size: size, imageExtension: imageExtension) ?? "")") else { return }
            if let data = try? Data(contentsOf: finalUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    
    private func createActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = frame
        addSubview(activityIndicator)
    }
    
    private func imageSize(size: ImageSize, imageExtension: ImageType) -> String {
        return "\(size.rawValue).\(imageExtension.rawValue)"
    }
    
}
