//
//  SectionSeparator.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 29/10/21.
//

import SwiftUI

struct SectionSeparator: View {

    var text: String

    var body: some View {
        VStack {

            Text(text)
                .font(.marvelRegular(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing], 16)
                .padding(.top, 4)

        }
        .background(Color.gray.opacity(0.2))
        .frame(maxWidth: .infinity)

    }

}
