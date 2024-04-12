//
//  noissy.swift

// A view of the main App. This view brings everything together.
// Places the header on top of the Combined View.
// Color Scheme, status bar activation are determined here

import SwiftUI

struct noissy: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !feedViewModel.currentTask && !feedViewModel.ContentLibrary.isEmpty{
                    noissyHeader(feedViewModel: feedViewModel)
                }
                CombinedView(feedViewModel: feedViewModel)
                    .padding(.top, 70)
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(mainColor)
            //.navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                    //SingleFeedView(feedViewModel: feedViewModel)
                
                
              //  if let selectedMovie = feedViewModel.selectedMovie {
                //    if let generatedMusic = feedViewModel.generatedMusic {
                  //      let audioData = Data(base64Encoded: generatedMusic.encodedData!)
                    //    let audioURL = dataToURL2(data: audioData! as NSData, url: "audioGen.wav")
                      //  EditView(feedViewModel: feedViewModel, videoURL: selectedMovie.url!, audioURL: audioURL, duration: selectedMovie.duration ?? 0.0)
                        //    .toolbar(.hidden)
                            
                    //}
                //}
                 
            //}
        }
        .tint(.white)
        .edgesIgnoringSafeArea(.all)
        .statusBarHidden(feedViewModel.hideStatusBar)
        .preferredColorScheme(.dark) //for setting the theme of the app, including the status bar color
    }
}

#Preview {
    noissy(feedViewModel: FeedViewModel())
       
}

