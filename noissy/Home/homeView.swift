//
//  homeView.swift


import SwiftUI

struct homeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                HeaderLabel()
                Spacer()
                openMedia(feedViewModel: feedViewModel)
                    
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    homeView(feedViewModel: FeedViewModel())
        .background(.black)
        
}
