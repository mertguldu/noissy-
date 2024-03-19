//
//  HomeView.swift

// HeaderLabel is the text that appears on top of the page.
// OpenMedia accesses the photo library using PhotoPicker. Only videos are accessible.

import SwiftUI

struct HomeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                HeaderLabel(feedViewModel: feedViewModel)
                Spacer()
                OpenMedia(feedViewModel: feedViewModel)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView(feedViewModel: FeedViewModel())
        .background(.black)
        
}
