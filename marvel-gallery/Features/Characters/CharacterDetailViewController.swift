//
//  CharacterDetailViewController.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 21/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import UIKit

protocol CharacterDetailViewControllerDelegate: class {
    func didDismissCharacterDetailViewController()
}

class CharacterDetailViewController: UIViewController {
    
    private let storyboardName: String = "Characters"
    
    @IBOutlet private var imageView: UIImageView?
    @IBOutlet private var charNameLabel: UILabel?
    @IBOutlet private var charDescriptionLabel: UILabel?
    
    weak var delegate: CharacterDetailViewControllerDelegate?
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
        addTapGestures()
        bindElements()
        setupData()
    }
    
    // MARK: - Actions
    
    @objc
    private func touchImageView(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: false) {
            self.delegate?.didDismissCharacterDetailViewController()
        }
    }
    
    // MARK: - Private methods
    
    private func addTapGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchImageView(tapGestureRecognizer:)))
        imageView?.isUserInteractionEnabled = true
        imageView?.addGestureRecognizer(tap)
    }
    
    private func setupData() {
        imageView?.image = charImage
        charNameLabel?.text = character?.name
        if let description = character?.description, !description.isEmpty {
            charDescriptionLabel?.text = description
        } else {
            charDescriptionLabel?.text = "Description not available"
        }
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
