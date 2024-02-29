//
//  SingleFeedView.swift


import SwiftUI

struct SingleFeedView: View {
    var feedViewModel: FeedViewModel
    var contentData: NSData? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            FeedContent(contentData: contentData)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.2, green: 0.0, blue: 0.2))
                .ignoresSafeArea()
            
                .toolbar(.visible)
                
                //.navigationBarBackButtonHidden(true)
                
        }
        .tint(.white)
    }
}


#Preview {
    SingleFeedView(feedViewModel: FeedViewModel())
}
