//
//  singleFeedView.swift


import SwiftUI

struct singleFeedView: View {
    let feed: feedModel<UIImage>.Feed //feed from feed model(logic)
    
    var body: some View {
        ZStack {
            singleFeedViewHeader() //back and the SHARE buttons are in this view (Header)

            Image(uiImage: feed.content) //place the feed content inside the image
                    .resizable() //resize the image based on the dimensions
                    .scaledToFit() // scale the image to fit to the dimensions
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height) //make the image dimensions the same as the device screen dimensions
        }
        .ignoresSafeArea() //Ignore the safe areas - fill the entire screen
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 0.2, green: 0.0, blue: 0.2))
        
    }
}


struct singleFeedViewHeader: View {
    var body: some View {
        VStack(spacing:0){
            HStack{
                Image(systemName: "chevron.left")
                .foregroundStyle(Color.white)
                Spacer()
                ShareLink(item: Image(systemName: "square.and.arrow.up"), preview: SharePreview("Share your video.", image: Image(systemName: "square.and.arrow.up"))) {
                    Label("Share", systemImage: "square.and.arrow.up")
                        .foregroundStyle(Color.white)
                } //share button
            }
            .padding()
            .padding(.top, 35) //CHANGE THE FIXED PADDING so that it fits every device
            Spacer()
        }
        .padding()
    }
}

#Preview {
    let example_Feed = feedModel.Feed(content: UIImage(systemName: "chevron.left")!)
    
    return singleFeedView(feed: example_Feed)
}
