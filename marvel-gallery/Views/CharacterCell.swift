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
    
    private var imageShimmer = FBShimmeringView()
    
    var path: String = ""
    var containerView: UIView?
    
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
    
    func moveImage(to position: CGPoint, size: CGSize) {
        let imageView = createCopyImage()
        UIView.animate(withDuration: 0.3) {
            imageView?.frame = CGRect(x: position.x,
                                      y: position.y,
                                      width: size.width,
                                      height: size.height)
        }
    }
    
    private func createCopyImage() -> UIImageView? {
        guard let frame = charImageView?.frame else { return nil }
        let point = findImageAbsPosition()
        let imageView = UIImageView(frame: CGRect(x: point.x,
                                                  y: point.y,
                                                  width: frame.width,
                                                  height: frame.height))
        
        imageView.image = charImageView?.image
        containerView?.addSubview(imageView)
        return imageView
    }
    
    private func findImageAbsPosition() -> CGPoint {
        guard let point = charImageView?.bounds.origin else {
            return CGPoint(x: 0, y: 0)
        }
        return contentView.convert(point, to: nil)
    }
    
    private func configShimmering() {
        imageShimmer.removeFromSuperview()
        imageShimmer = FBShimmeringView(frame: imageShimmeringView?.bounds ?? bounds)
        imageShimmer.shimmeringOpacity = 1
        imageShimmer.shimmeringSpeed = shimmeringSpeed
        imageShimmer.contentView = imageShimmeringView
        imageShimmer.isShimmering = true
        addSubview(imageShimmer)
    }
    
}
