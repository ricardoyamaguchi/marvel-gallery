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
    private var viewModel: CharacterDetailViewModel

    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {

            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onReceive(imageLoaderViewModel.$imageData) { data in
                        image = UIImage(data: data) ?? UIImage()
                    }
                if imageLoaderViewModel.loading {
                    ActivityIndicator()
                }
            }

            VStack {

                Text(L10n.characterDetailsAbout.text.uppercased())
                    .font(.marvelRegular(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.leading, .trailing], 16)
                    .padding(.top, 4)

            }
            .background(Color.gray.opacity(0.2))
            .frame(maxWidth: .infinity)

            VStack(alignment: .leading) {

                Text(viewModel.getCharacterDescription())
                    .font(.heeboLight(size: 16))

            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 8)
            .navigationTitle(viewModel.getCharacterName())

        }.onAppear {
            imageLoaderViewModel.loadImage(from: viewModel.getCharacterThumbnailPath(),
                                           size: .standardFantastic, fileExtension: .jpg)
        }
    }
}
