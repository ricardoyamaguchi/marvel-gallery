//
//  CharacterDetailViewController.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 21/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    private let storyboardName: String = "Characters"
    
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var charNameLabel: UILabel?
    @IBOutlet private var charDescriptionLabel: UILabel?
    
    var viewModel: CharacterDetailViewModel?
    var charImage: UIImage?
    var character: Character?
    
    // MARK: - Initializaers

    static func instantiate(viewModel: CharacterDetailViewModel = CharacterDetailViewModel()) -> CharacterDetailViewController {
        let viewController: CharacterDetailViewController = UIStoryboard.viewController(nibName: "Characters")
        viewController.viewModel = viewModel
        return viewController
    }

    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()
        setupData()
    }
    
    private func setupData() {
        imageView?.image = charImage
        charNameLabel?.text = character?.name
        charDescriptionLabel?.text = character?.description
    }
    
    private func bindElements() {
        viewModel?.image.bind { [weak self] value in
            self?.imageView?.image = UIImage(data: value)
        }
        viewModel?.charDescription.bind { [weak self] value in
            self?.charDescriptionLabel?.text = value
        }
    }
    
}
