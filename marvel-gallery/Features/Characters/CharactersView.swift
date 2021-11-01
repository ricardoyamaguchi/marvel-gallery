//
//  CharactersView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 13/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharactersView: View {

    init() {
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont.marvelRegular(size: 32.0)
        ]
    }

    var body: some View {
        ZStack(alignment: .top) {
            VStack {

                Text(L10n.mainPageTitle.text)
                    .font(Font.marvelRegular(size: 60))

                Spacer()

                NavigationView {

                    VStack {
                        BodyView()
                        FooterView()
                    }
                    .frame(maxWidth: .infinity)
                    .navigationTitle(L10n.charactersTitle.text)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button(action: searchTapped) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .padding(.bottom, 8)
                        }
                        .foregroundColor(.gray)
                    }

                }

            }

        }
    }

    private func searchTapped() {

    }

}

private struct BodyView: View {

    @ObservedObject var viewModel = CharactersViewModel()

    let columns = [
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top),
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top),
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top)
    ]

    init() {
        fetchCharactersList()
    }

    var body: some View {
        ZStack(alignment: .center) {
            if viewModel.characters.count == 0, !viewModel.loading {
                VStack {
                    Text(L10n.charactersEmptyState.text)
                        .font(.heeboLight(size: 20.0))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {

                        Text(L10n.charactersMessage.text)
                            .font(.heeboLight(size: 16.0))
                            .frame(maxWidth: .infinity, alignment: .center)

                    }
                    .padding([.leading, .trailing], 16.0)
                    LazyVGrid(columns: columns, spacing: 16) {

                        ForEach(viewModel.characters, id: \.self) { character in
                            ImageCellView(character: character)
                                .onAppear {
                                    viewModel.fetchCharactersIfNeeded(currentCharacter: character)
                                }
                        }

                    }
                }
            }
            if viewModel.loading {
                VStack {
                    ActivityIndicator()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3))
            }
        }
    }

    private func fetchCharactersList() {
        viewModel.fetchCharactersList()
    }

}

private struct ImageCellView: View {

    @State var height = 4.0
    @State var tapped = false
    @State var alpha = 1.0

    var character: Character

    init(character: Character) {
        self.character = character
    }

    var body: some View {
        VStack {
            NavigationLink(
                destination: CharacterDetailView(
                    viewModel: CharacterDetailViewModel(character: character)),
                isActive: $tapped) {
                EmptyView()
            }
            .hidden()

            WebImage(url: url())
                .resizable()
                .placeholder(
                    Image(uiImage: UIImage(named: "black-panther") ?? UIImage())
                )
                .frame(width: 120, height: 120, alignment: .center)

            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(.black)
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
                        .background(Color.clear)

                }

            }
            .padding(.top, -8)
        }.onAppear {
            withAnimation(.spring()) {
                tapped = false
                height = 4.0
                alpha = 1.0
            }

        }
        .onTapGesture {
            withAnimation(.spring()) {
                tapped.toggle()
                height = tapped ? 80.0 : 4.0
                alpha = tapped ? 0.7 : 1.0
            }
        }
        .frame(height: 200)
        .opacity(alpha)
        .shadow(color: .gray.opacity(0.3), radius: 5.0)
    }

    private func url() -> URL? {
        return URL(string:
                    String.urlImage(for: character.thumbnail?.path ?? "",
                                       size: .standardLarge,
                                       imageExtension: .jpg)
        )
    }

}

private struct FooterView: View {
    var body: some View {

        VStack {

            Text("Copyright: © 2021 MARVEL")
                .font(.heeboThin(size: 12.0))
                .frame(maxWidth: .infinity)

        }
        .background(Color.gray.opacity(0.3))

    }
}