//
//  Modifiers.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 01/11/21.
//

import SwiftUI

struct LabelModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.heeboMedium(size: 16.0))
    }

}

struct ContentModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.heeboLight(size: 16.0))
    }

}
