//
//  UIViewController.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 21/04/19.
//  Copyright © 2019 Ricardo Yamaguchi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func storyboardId() -> String? {
        return String(describing: self)
    }
    
}
