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
    @State var text = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(label)
                .modifier(LabelModifier())
                .padding()
            TextField(placeholder, text: $text)
                .frame(height: 32.0)
                .background(Color.jet)
                .cornerRadius(8)
                .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color(uiColor: .systemGray))
        )
        .background(.thinMaterial)
        .frame(maxWidth: .infinity)
        .frame(height: 50.0)
    }

}
