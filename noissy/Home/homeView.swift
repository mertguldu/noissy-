//
//  homeView.swift


import SwiftUI

struct homeView: View {
    var feedViewModel: FeedViewModel = FeedViewModel()

    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                Text("Click to upload your video")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()
                openMedia(feedViewModel: feedViewModel)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    homeView()
        .background(.black)
        
}
