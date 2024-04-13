//
//  OpenMedia.swift
//  noissy
// Opens photo library. When a video is selected, its data is sent to the backend to generate a music using the video. 

import AVKit
import PhotosUI
import SwiftUI

struct OpenMedia: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            NavigationStack {
                if !feedViewModel.currentTask {
                    PhotosPicker(selection: $selectedItem, matching: .videos){
                        Logo()
                    }
                    .onChange(of: selectedItem) { _ in
                        Task {
                            do {
                                if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
                                    selectedItem = nil
                                    var data: NSData? = NSData(contentsOf: movie.url)
                                    let durationOfVideo = await videoDuration(videoURL: movie.url)
                                    
                                    if durationOfVideo <= 30.0 {
                                        generateImageFromVideo(videoURL: movie.url, videoDuration: 0, progress: 0, size: CGSize(width: 300, height: 0)) { image in
                                            feedViewModel.imagePreviewData = image.pngData()
                                        }

                                        let selectedMovie = SelectedMovie(url: movie.url, encodedData: data!.base64EncodedString(), duration: durationOfVideo)
                                        feedViewModel.selectedMovie = selectedMovie
                                        feedViewModel.currentTask = true
                                        
                                        if let userID = feedViewModel.userID {
                                            generateMusic(encodedData: data!.base64EncodedString(), userID: userID, feedViewModel: feedViewModel)
                                        }
                                        data = nil
                                    } else {
                                        feedViewModel.isErrorOccured = true
                                        feedViewModel.errorMessage = "Video can't be longer than 30 secs"
                                    }
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    .padding(.top, -200)
                    //.photosPickerAccessoryVisibility(.hidden, edges: .bottom)  //not available before ios17
                } else {
                    progressLogo()
                        .padding(.top, -200)
                }
            }
        }
    }
}

#Preview {
    OpenMedia(feedViewModel: FeedViewModel())
 
}
