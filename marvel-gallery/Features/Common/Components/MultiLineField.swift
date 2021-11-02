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
                .modifier(LabelModifier())
            Text(text)
                .modifier(ContentModifier())
        }
    }

}
