//
//  InlineField.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 29/10/21.
//

import SwiftUI

struct SingleLineField: View {

    var label: String
    var text: String

    var body: some View {
        HStack(alignment: .top) {
            Text(label + ":")
                .font(.heeboMedium(size: 16))
            Text(text)
                .lineLimit(2)
                .font(.heeboLight(size: 16))
            Spacer()
        }
        .padding(.bottom, 8)
        .frame(maxWidth: .infinity)
    }

}
