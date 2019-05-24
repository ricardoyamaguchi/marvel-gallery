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

protocol CharacterCellDelegate: class {
    func closeCell(_ cell: CharacterCell)
}

class CharacterCell: UITableViewCell {

    private let shimmeringSpeed: CGFloat = 115
    
    @IBOutlet private weak var charImageView: UIImageView?
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet weak var imageShimmeringView: UIView?
    
    private var imageShimmer = FBShimmeringView()
    private var path: String = ""
    
    var rootContainer: CharactersViewController?
    weak var delegate: CharacterCellDelegate?
    
    var character: Character? {
        didSet {
            path = character?.thumbnail?.path ?? ""
            nameLabel?.text = character?.name
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
        configTapGesture()
    }
    
    @objc
    func close() {
        delegate?.closeCell(self)
    }
    
    func findImageAbsPosition() -> CGPoint {
        guard let point = charImageView?.bounds.origin else {
            return CGPoint(x: 0, y: 0)
        }
        return contentView.convert(point, to: nil)
    }
    
    func getCharImageView() -> UIImageView? {
        return charImageView
    }
    
    private func configTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(close))
        charImageView?.addGestureRecognizer(gesture)
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
