//
//  MenuView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 06/11/21.
//

import SwiftUI

struct MenuView: View {

    private let charactersBackground = UIImage(named: "characters-background") ?? UIImage()

    @State private var openCharacters = false

    var body: some View {
        VStack {
            pageTitle
            Spacer()
            content
        }
    }

    private var pageTitle: some View {
        Text(L10n.mainPageTitle.text)
            .font(Font.marvelRegular(size: 60))
    }

    private var content: some View {
        NavigationView {
            VStack {
                charactersArea
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }

    private var charactersArea: some View {
        Group {
            MenuAreaView(
                imageName: "characters-background",
                label: "Characters",
                alignment: .bottomTrailing,
                action: charactersButtonTap)

            NavigationLink("", destination: CharactersView(), isActive: $openCharacters)
                .hidden()
        }

    }

    private func charactersButtonTap() {
        openCharacters.toggle()
    }

    init() {
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.marvelRegular(size: 32.0)
        ]
    }

}

struct MenuViewPreviews: PreviewProvider {

    static var previews: some View {
        MenuView()
    }

}
