//
//  SimpleSearchBox.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 31/10/21.
//

import SwiftUI

struct SimpleSearchBox: View {

    @State var label = ""
    @State var placeholder = ""
    @Binding var text: String
    @FocusState var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(label)
                .modifier(LabelModifier())
            HStack(spacing: 4.0) {
                TextField(placeholder, text: $text)
                    .padding(8.0)
                    .background(Color(uiColor: .systemGray))
                    .cornerRadius(5.0)
                    .focused($focused)
                Button(action: buttonAction) {
                    Text(L10n.okLabel.text)
                        .modifier(LabelModifier())
                        .padding(8.0)
                }
                .modifier(ButtonModifier())
                .foregroundColor(Color(uiColor: .systemGray))
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color(uiColor: .systemGray))
        )
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .fill(.thinMaterial)
        )
        .frame(maxWidth: .infinity)
        .frame(height: 50.0)
        .onAppear {
            focused = true
        }
    }

    private func buttonAction() {

    }

}
