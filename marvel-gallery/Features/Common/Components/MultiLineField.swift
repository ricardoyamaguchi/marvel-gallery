//
//  MultiLineField.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 29/10/21.
//

import SwiftUI

struct MultiLineField: View {

    var label: String
    var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label + ":")
                .font(.heeboMedium(size: 16))
            Text(text)
                .font(.heeboLight(size: 16))
        }
    }

}
