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
    
    private let provider = CharactersProvider()
    private var characters: [Character] = []
    private var cachedImages: [String: UIImage] = [:]
    private var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchCharacters()
    }
    
    private func configTableView() {
        tableView?.register(UINib(nibName: "CharacterCell", bundle: nil),
                            forCellReuseIdentifier: "CharCell")
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    private func fetchCharacters() {
        activityIndicator?.startAnimating()
        loadingView?.isHidden = false
        provider.getList(offset: characters.count) {[weak self] result in
            guard let data = result, let results = data.results  else { self?.stopLoading(); return }
            self?.total = data.total ?? 0
            self?.updateData(results)
        }
    }
    
    private func updateData(_ result: [Character]) {
        characters.append(contentsOf: result)
        tableView?.reloadData()
        stopLoading()
    }
    
    private func stopLoading() {
        activityIndicator?.stopAnimating()
        loadingView?.isHidden = true
    }

}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item selected")
    }
}

extension CharactersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharCell") as? CharacterCell else { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        
        cell.name = character.name
        cell.thumbnail = character.thumbnail
        cell.charImage = nil
        
        downloadImage(into: cell)
        
        if indexPath.row == characters.count - 2, characters.count < total {
            fetchCharacters()
        }
        
        return cell
    }
    
    private func downloadImage(into cell: CharacterCell) {
        guard let path = cell.thumbnail?.path else { return }
        if let image = cachedImages[path] {
            cell.charImage = image
        } else {
            ImageProvider.fetchImage(from: path,
                                     size: .standardSmall,
                                     type: cell.thumbnail?.type ?? .jpg) { [weak self] imageData in
                                        guard let data = imageData, let image = UIImage(data: data) else { return }
                                        cell.charImage = image
                                        self?.cachedImages[path] = image
            }
        }
    }
}
