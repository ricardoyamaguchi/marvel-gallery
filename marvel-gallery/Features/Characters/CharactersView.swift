//
//  CharactersView.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 13/10/21.
//

import SwiftUI

struct CharactersView<ViewModel>: View where ViewModel: CharactersViewModelProtocol {

    // MARK: - Private properties

    @State private var isSearching = false
    @State private var searchName: String = ""

    private let columns = [
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top),
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top),
        GridItem(.flexible(minimum: 100, maximum: 120), alignment: .top)
    ]

    // MARK: - Public properties

    @ObservedObject var viewModel: ViewModel

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                content
                footer
            }
            .navigationTitle(L10n.charactersTitle.text)
            .toolbar { toolbarButtons }

            if isSearching { searchBox }
        }
    }

    private var toolbarButtons: some View {
        Group {
            Button(action: searchTapped) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .padding(.bottom, 8)
                    .foregroundColor(.gray)
            }
        }
    }

    private var content: some View {
        ZStack {
            if viewModel.characters.count == 0, !viewModel.loading { emptyState } else { characters }
            if viewModel.loading { loading }
        }
    }

    private var emptyState: some View {
        Group {
            Text(L10n.charactersEmptyState.text)
                .font(.heeboLight(size: 20.0))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
        }
    }

    private var charactersText: some View {
        Group {
            Text(L10n.charactersMessage.text)
                .font(.heeboLight(size: 16.0))
                .frame(maxWidth: .infinity)
                .padding([.leading, .trailing], 16.0)
        }
    }

    private var characters: some View {
        ScrollView(.vertical, showsIndicators: false) {
            charactersText

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.characters, id: \.self) { character in
                    CharacterImageCellView(character: character)
                        .onAppear {
                            viewModel.fetchCharactersIfNeeded(currentCharacter: character)
                        }
                }
            }
        }
    }

    private var loading: some View {
        Group {
            ActivityIndicator()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.3))
        }
    }

    private var searchBox: some View {
        Group {
            SimpleSearchBox(label: L10n.charactersSearchLabel.text,
                            placeholder: L10n.charactersSearchPlaceholder.text,
                            text: $searchName)
                .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                .frame(maxWidth: .infinity)
                .padding(.top, 27.0)
        }
    }

    private var footer: some View {
        Group {
            Text("Copyright: © 2021 MARVEL")
                .font(.heeboThin(size: 12.0))
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                .background(Color.gray.opacity(0.3))
                .padding(.top, -8)
        }
    }

    // MARK: - Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.viewModel.fetchCharactersList(name: nil)
    }

    // MARK: - Private methods

    private func searchTapped() {
        withAnimation(.easeInOut(duration: 0.3)) {
            isSearching.toggle()
        }
    }

}
