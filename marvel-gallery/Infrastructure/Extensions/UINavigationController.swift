//
//  UINavigationController.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 15/10/21.
//

import UIKit

extension UINavigationController {

    open override func viewWillLayoutSubviews() {
        let barButton = UIBarButtonItem(title: navigationBar.topItem?.title, style: .plain, target: nil, action: nil)
        barButton.setTitleTextAttributes([.font: UIFont.marvelRegular(size: 16.0)], for: .normal)
        barButton.setTitleTextAttributes([.font: UIFont.marvelRegular(size: 16.0)], for: .application)
        navigationBar.topItem?.backBarButtonItem = barButton
    }

}
