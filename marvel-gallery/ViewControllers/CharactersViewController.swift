//
//  CharactersViewController.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 03/02/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var loadingView: UIView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?
    
    private let viewModel = CharactersViewModel()
    private var cachedImages: [String: UIImage] = [:]
    var openImageView = UIImageView()
    var openImageViewOrigin = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        bindElements()
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        loadingView?.isHidden = false
        activityIndicator?.startAnimating()
        viewModel.fetchCharacters()
    }
    
    private func configTableView() {
        tableView?.register(UINib(nibName: "CharacterCell", bundle: nil), forCellReuseIdentifier: "CharCell")
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    private func updateData() {
        tableView?.reloadData()
        activityIndicator?.stopAnimating()
        loadingView?.isHidden = true
    }
    
    private func bindElements() {
        viewModel.data.bind { [weak self] _ in
            self?.updateData()
        }
    }

}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        animateImage(tableView: tableView, indexPath: indexPath)
        pushToDetails()
    }
    
    private func animateImage(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CharacterCell, let y = navigationController?.navigationBar.frame.size.height else { return }
        let size = targetSize()
        let x = UIScreen.main.bounds.width - (size.width / 2)
        cell.openCharacterEffect(to: CGPoint(x: x, y: y), size: size)

    }
    
    private func targetSize() -> CGSize {
        return CGSize(width: 250.0, height: 250.0)
    }
    
    private func pushToDetails() {
        
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharCell") as? CharacterCell else { return UITableViewCell() }
        
        let character = viewModel.characters[indexPath.row]
        cell.name = character.name
        cell.charImage = nil
        cell.path = character.thumbnail?.path ?? ""
        cell.rootContainer = self
        viewModel.fetchImage(index: indexPath.row) { path, data in
            if path == cell.path {
                let image = UIImage(data: data)
                cell.charImage = image
            }
        }
        
        let count = viewModel.characters.count
        if indexPath.row == count - 2, count < viewModel.total {
            fetchCharacters()
        }
        
        return cell
    }
    
}
