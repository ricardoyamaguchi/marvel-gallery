//
//  MarvelButton.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 06/11/21.
//

import SwiftUI

struct MarvelButton: View {

    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.heeboMedium(size: 16.0))
                .foregroundColor(.white)
                .padding(24.0)
                .frame(height: 48.0)
                .background(Color.redPigment)
                .clipShape(MarvelButtonShape(cornerHeight: 16.0, cornerWidth: 16.0))
                .shadow(color: .black.opacity(0.7), radius: 10, x: 1, y: 1)
        }
    }
}
