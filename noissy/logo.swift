//
//  logo.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct logo: View {
    var body: some View {
        Circle()
            .frame(width: 200)
            .foregroundStyle(Color(red: 0.5, green: 0, blue: 0.5))
            .overlay(Image("logo-crop").resizable().frame(width: 125, height: 125))
    }
}


#Preview {
    logo()
}
