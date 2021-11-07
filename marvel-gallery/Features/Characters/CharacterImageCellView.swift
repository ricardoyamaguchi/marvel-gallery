//
//  CharacterImageCellView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 06/11/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterImageCellView: View {

    @State var height = 4.0
    @State var tapped = false
    @State var opacity = 1.0

    var character: Character

    init(character: Character) {
        self.character = character
    }

    var body: some View {
        VStack {
            navigationLink
            image
            footer
        }
        .onAppear(perform: didAppear)
        .onTapGesture(perform: didTap)
        .frame(height: 200)
        .shadow(color: .gray.opacity(0.5), radius: 8, x: 1.0, y: 1.0)
    }

    private var navigationLink: some View {
        NavigationLink(
            destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character)),
            isActive: $tapped) {
            EmptyView()
        }
        .hidden()
    }

    private var image: some View {
        Group {
            WebImage(url: url())
                .resizable()
                .placeholder(
                    Image(uiImage: UIImage(named: "black-panther") ?? UIImage())
                )
                .frame(width: 120, height: 120)
        }
    }

    private var footer: some View {
        ZStack(alignment: .top) {

            MarvelCharShape(cornerHeight: 12.0, cornerWidth: 12.0)
                .fill(.black)
                .frame(height: 80.0)

            Rectangle()
                .foregroundColor(.redPigment)
                .frame(height: height)

            VStack {
                Text(character.name?.uppercased() ?? "")
                    .font(.marvelRegular(size: 16))
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    .multilineTextAlignment(.center)
                Spacer()
            }

        }
        .padding(.top, -8)

    }

    // MARK: - Private methods

    private func url() -> URL? {
        return URL(string:
                    String.urlImage(for: character.thumbnail?.path ?? "",
                                       size: .standardLarge,
                                       imageExtension: .jpg)
        )
    }

    private func didAppear() {
        withAnimation(.spring()) {
            height = 4.0
        }
    }

    private func didTap() {
        withAnimation(.spring()) {
            tapped.toggle()
            height = tapped ? 80.0 : 4.0
        }

    }

}
