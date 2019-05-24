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

    @IBOutlet weak var searchTextField: UITextField?
    private let viewModel = CharactersViewModel()

    private var cachedImages: [String: UIImage] = [:]
    private var imageTargetSize: CGSize {
        return CGSize(width: 250.0, height: 250.0)
    }
    private var imageTargetPosition: CGPoint {
        return CGPoint(x: (UIScreen.main.bounds.width / 2) - (imageTargetSize.width / 2),
                       y: view.safeAreaInsets.top)
    }

    var openImageView = UIImageView()
    var openImageViewOrigin = CGPoint()
    var selectedCell: CharacterCell?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        configTableView()
        bindElements()
        fetchCharacters()
        configNavigationBar()
    }

    @IBAction func okButtonAction(_ sender: Any) {
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        loadingView?.isHidden = false
        activityIndicator?.startAnimating()
        viewModel.fetchCharacters(name: searchTextField?.text ?? "")
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
    
    private func configNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        push(tableView: tableView, indexPath: indexPath)
    }

    private func push(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CharacterCell else { return }
        zoomImage(from: cell, to: imageTargetPosition, targetSize: imageTargetSize) {
            self.pushToDetails(indexPath)
        }
        selectedCell = cell
    }
    
    func zoomImage(from cell: CharacterCell, to position: CGPoint, targetSize: CGSize, completion: @escaping () -> Void) {
        let imageView = copyImageView(from: cell)
        cell.getCharImageView()?.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            imageView?.frame = CGRect(x: position.x,
                                      y: position.y,
                                      width: targetSize.width,
                                      height: targetSize.height)
        }, completion: { _ in
            completion()
        })
    }

    private func copyImageView(from cell: CharacterCell) -> UIImageView? {
        guard let frame = cell.getCharImageView()?.frame else { return nil }
        let point = cell.findImageAbsPosition()
        let imageView = UIImageView(frame: CGRect(x: point.x,
                                                  y: point.y,
                                                  width: frame.width,
                                                  height: frame.height))
        
        imageView.image = cell.getCharImageView()?.image
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = cell.getCharImageView()?.contentMode ?? .scaleAspectFill
        
        openImageViewOrigin = point
        openImageView = imageView
        
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(imageView)
        
        return imageView
    }

    private func pushToDetails(_ indexPath: IndexPath) {
        let details = CharacterDetailViewController.instantiate()
        details.character = viewModel.characters[indexPath.row]
        details.delegate = self
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .fade
        transition.subtype = .fromBottom
        
        view.window?.layer.add(transition, forKey: kCATransition)
        navigationController?.present(details, animated: true) {
            self.openImageView.isHidden = true
            details.charImage = self.openImageView.image
        }
    }
}

extension CharactersViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharCell") as? CharacterCell else { return UITableViewCell() }

        cell.character = viewModel.characters[indexPath.row]
        cell.charImage = nil
        cell.rootContainer = self
        
        viewModel.fetchImage(index: indexPath.row) { path, data in
            if path == cell.character?.thumbnail?.path {
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

extension CharactersViewController: CharacterCellDelegate {
    func closeCell(_ cell: CharacterCell) {
        view.isUserInteractionEnabled = false
        openImageView.isHidden = false
        animateCloseCell(cell)
    }
    
    func animateCloseCell(_ cell: CharacterCell) {
        guard let size = cell.getCharImageView()?.frame.size else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.openImageView.frame = CGRect(x: self.openImageViewOrigin.x,
                                              y: self.openImageViewOrigin.y,
                                              width: size.width,
                                              height: size.height)
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
            self.openImageView.removeFromSuperview()
            cell.getCharImageView()?.alpha = 1
        })

    }
    
}

extension CharactersViewController: CharacterDetailViewControllerDelegate {
    func didDismissCharacterDetailViewController() {
        guard let cell = selectedCell else { return }
        closeCell(cell)
    }
}
