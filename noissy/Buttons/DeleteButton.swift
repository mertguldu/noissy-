//
//  DeleteButton.swift
//  noissy
//
//  Created by Mert Guldu on 3/2/24.
//

import SwiftUI

struct DeleteButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var feedID: Int?
    var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        Button(action: {
            if let id = feedID {
                let feed = feedViewModel.ContentLibrary[id]
                feedViewModel.delete(feed: feed)
            }
            self.presentationMode.wrappedValue.dismiss()
            print("deleting")
        }, label: {
            Image(systemName: "trash")
                .foregroundStyle(Color.white)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        })
        
    }
}

#Preview {
    DeleteButton()
}
