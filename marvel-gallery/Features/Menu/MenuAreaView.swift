//
//  MenuAreaView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 07/11/21.
//

import SwiftUI

struct MenuAreaView: View {

    var imageName: String
    var label: String
    var alignment: Alignment
    var action: () -> Void

    var body: some View {
        ZStack(alignment: alignment) {
            image
            button
        }
    }

    private var image: some View {
        Image(uiImage: UIImage(named: imageName) ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(
                width: UIScreen.main.bounds.width,
                height: 100
            )
            .clipped()
            .opacity(0.6)
    }

    private var button: some View {
        MarvelButton(label: label, action: action)
            .padding(4.0)
    }
}
