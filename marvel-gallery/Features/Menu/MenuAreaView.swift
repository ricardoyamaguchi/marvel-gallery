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
           Image(uiImage: UIImage(named: imageName) ?? UIImage())
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .clipped()

            MarvelButton(label: label, action: action)
                .padding(4.0)
        }
    }
}

struct MenuAreaViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            MenuAreaView(
                imageName: "characters-background",
                label: "Characters",
                alignment: .bottomTrailing) {

            }

            MenuAreaView(
                imageName: "characters-background",
                label: "Comics",
                alignment: .bottomLeading) {

            }
        }
    }
}
