//
//  conView.swift
//  noissy
//
//  Created by Mert Guldu on 2/28/24.
//

import SwiftUI

struct conView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                VideoPickerView()
                    .toolbar(.hidden)
            } label: {
                Text("Choose a Video")
            }

        }
    }
}

#Preview {
    conView()
}

