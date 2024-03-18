//
//  logo.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Circle()
            .frame(width: 200)
            .foregroundStyle(logoColor)
            .overlay(Image("logo-crop").resizable().frame(width: 125, height: 125))
    }
}


#Preview {
    Logo()
}
