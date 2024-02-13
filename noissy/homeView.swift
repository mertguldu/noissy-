//
//  homeView.swift


import SwiftUI
import PhotosUI


struct homeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    
    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                Text("Click to upload your video")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Spacer()
                
                //For opening the photo library
                PhotosPicker(selection: $feedViewModel.imageSelection, matching:.any(of: [.images, .videos])) {
                    Circle()
                        .frame(width: 200)
                        .foregroundStyle(Color(red: 0.5, green: 0, blue: 0.5))
                        .overlay(Image("logo-crop").resizable().frame(width: 125, height: 125))
                }
                .padding(.top, -200)
                .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
                
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
