//
//  CharacterDetailView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import SwiftUI

struct CharacterDetailView: View {

    // Needed to adapt for small devices, according to image proportions (464x261).
    // This avoids the screen to be resized automatically after loading as the
    // final screen size is set since its first display.
    private let proportionalImageHeight = 0.5625 * UIScreen.main.bounds.width

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
        .frame(height: proportionalImageHeight)

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
