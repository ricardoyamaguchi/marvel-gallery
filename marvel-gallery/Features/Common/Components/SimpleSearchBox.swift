//
//  SimpleSearchBox.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 31/10/21.
//

import SwiftUI

struct SimpleSearchBox: View {

    @State var label = ""
    @State var text = ""

    var body: some View {
        VStack {
            TextField(label, text: $text)
        }
        .border(Color.eerieBlack)
        .frame(maxWidth: .infinity)
        .frame(height: 50.0)
        .onAppear {
        }

    }

}
