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
    var rootContainer: CharactersViewController?
    
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
    
    func openCharacterEffect(to position: CGPoint, size: CGSize, completion: @escaping () -> Void) {
        let imageView = copyImageView()
        charImageView?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            imageView?.frame = CGRect(x: position.x,
                                      y: position.y,
                                      width: size.width,
                                      height: size.height)
        }) { _ in
            completion()
        }
    }
    
    @objc
    func closeCharacterEffect() {
        guard let targetPosition = rootContainer?.openImageViewOrigin, let size = charImageView?.frame.size else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.rootContainer?.openImageView.frame = CGRect(x: targetPosition.x,
                                                             y: targetPosition.y,
                                                             width: size.width ,
                                                             height: size.height)
        }, completion: { _ in
            self.charImageView?.alpha = 1
            self.rootContainer?.openImageView.removeFromSuperview()
        })
    }
    
    private func copyImageView() -> UIImageView? {
        guard let frame = charImageView?.frame else { return nil }
        let point = findImageAbsPosition()
        let imageView = UIImageView(frame: CGRect(x: point.x,
                                                  y: point.y,
                                                  width: frame.width,
                                                  height: frame.height))
        
        imageView.image = charImageView?.image
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = charImageView?.contentMode ?? .scaleAspectFill
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeCharacterEffect))
        imageView.addGestureRecognizer(gesture)
        rootContainer?.openImageViewOrigin = point
        rootContainer?.openImageView = imageView
        rootContainer?.view.addSubview(imageView)
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
