//
//  CharacterCell.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 31/03/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import Foundation
import Shimmer
import UIKit

class CharacterCell: UITableViewCell {

    private let shimmeringSpeed: CGFloat = 115
    
    @IBOutlet private weak var charImageView: CustomImageView?
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet weak var imageShimmeringView: UIView?
    
    var thumbnail: Thumbnail?
    var imageShimmer = FBShimmeringView()
    
    var name: String? {
        didSet {
            nameLabel?.text = name
        }
    }
    
    var charImage: UIImage? {
        didSet {
            charImageView?.image = charImage
            imageShimmeringView?.isHidden = (charImage != nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configShimmering()
    }
    
    private func configShimmering() {
        imageShimmer = FBShimmeringView(frame: imageShimmeringView?.bounds ?? bounds)
        imageShimmer.shimmeringOpacity = 1
        imageShimmer.shimmeringSpeed = shimmeringSpeed
        imageShimmer.contentView = imageShimmeringView
        imageShimmer.isShimmering = true
        addSubview(imageShimmer)
    }
    
}
