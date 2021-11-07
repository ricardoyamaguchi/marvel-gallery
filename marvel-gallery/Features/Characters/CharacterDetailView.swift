//
//  CharacterDetailView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import SwiftUI

struct CharacterDetailView: View {

    @ObservedObject private var imageLoaderViewModel = ImageLoaderViewModel()
    @State private var image = UIImage()

    var viewModel: CharacterDetailViewModel

    var body: some View {
        ScrollView {
            header
            about
            comics
        }.onAppear {
            imageLoaderViewModel.loadImage(
                from: viewModel.getCharacterThumbnailPath(),
                size: .landscapeIncredible, fileExtension: .jpg
            )
        }
        .navigationTitle(viewModel.getCharacterName())
    }

    private var header: some View {
        ZStack {

            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .onReceive(imageLoaderViewModel.$imageData) { data in
                    image = UIImage(data: data) ?? UIImage()
                }
            if imageLoaderViewModel.loading {
                ActivityIndicator()
            }

        }
        .frame(height: 220)
    }

    private var about: some View {
        Group {
            SectionSeparator(text: L10n.characterDetailsAbout.text.uppercased())
            VStack(alignment: .leading) {
                SingleLineField(
                    label: L10n.nameLabel.text,
                    text: viewModel.getCharacterName()
                )
                MultiLineField(
                    label: L10n.descriptionLabel.text,
                    text: viewModel.getCharacterDescription()
                )
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 8)
        }
    }

    private var comics: some View {
        Group {
            SectionSeparator(text: L10n.comicsLabel.text.uppercased())
            EmptyView()
        }
    }
}
