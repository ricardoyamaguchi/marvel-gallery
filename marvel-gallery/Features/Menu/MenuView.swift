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
    @State private var openComics = false

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
            ScrollView {
                VStack {
                    charactersArea
                    comicsArea
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
            }
        }
    }

    private var charactersArea: some View {
        Group {
            MenuAreaView(
                imageName: "characters-background",
                label: L10n.charactersTitle.text,
                alignment: .bottomTrailing,
                action: charactersButtonTap)

            NavigationLink(
                "",
                destination: charactersDestination,
                isActive: $openCharacters)
                .hidden()
        }

    }

    private var charactersDestination: some View {
        CharactersView<CharactersViewModel>(viewModel: CharactersViewModel())
    }

    private var comicsArea: some View {
        Group {
            MenuAreaView(
                imageName: "comics-background",
                label: L10n.comicsTitle.text,
                alignment: .bottomTrailing,
                action: comicsButtonTap)

            NavigationLink("", destination: ComicsView(), isActive: $openComics)
                .hidden()
        }

    }

    private func charactersButtonTap() {
        openCharacters.toggle()
    }

    private func comicsButtonTap() {
        openComics.toggle()
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
