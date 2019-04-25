//
//  UIStoryboard.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 21/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static func viewController<T: UIViewController>(nibName: String) -> T {
        let storyboard = UIStoryboard(name: nibName, bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.storyboardId() ?? "") as? T else { return T.init()}
        return viewController
    }
    
}
