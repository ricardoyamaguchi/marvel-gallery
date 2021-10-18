//
//  ActivityIndicator.swift
//  marvel-gallery
//
//  Created by Ricardo Yamaguchi on 17/10/21.
//

import SwiftUI

struct ActivityIndicator: View {

    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .redPigment))
            .scaleEffect(3)
    }

}
