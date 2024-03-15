//
//  OpenMedia.swift
//  noissy


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
                                    let data = NSData(contentsOf: movie.url)!
                                    let cgimage = await generateImageFromVideo(videoUrl: movie.url)
                                    let imageData = UIImage(cgImage: cgimage!).pngData()
                                    let asset = AVURLAsset(url: movie.url)
                                    
                                    let durationOfVideo = Float(try await asset.load(.duration).seconds)
                                    let fps = await getVideoFPS(videoURL: movie.url)
                                    let videoSizeMB = Float(data.length) / Float(1024.0 * 1024.0)
                                    let sizePerFrame = videoSizeMB / ( durationOfVideo * fps)

                                    if durationOfVideo <= 30.0 {
                                        feedViewModel.imagePreviewData = imageData // one time value
                                        feedViewModel.selectedMovie = data.base64EncodedString() // one time value
                                        feedViewModel.currentTask = true
                                        
                                        NetworkService.shared.sendVideoData(videoData: data.base64EncodedString(), sizePerFrame: String(sizePerFrame)) {(result) in
                                            switch result {
                                                case .success(let musicData):
                                                    print("backend result is successfull")
                                                    feedViewModel.musicDataString = musicData
                                                    feedViewModel.newMerge = true
                                                    feedViewModel.isTaskCompleted = true
                                                case .failure(let error):
                                                    print("error:", error.localizedDescription)
                                                    feedViewModel.currentTask = false
                                                    feedViewModel.isErrorOccured = true
                                                    if error.localizedDescription == "The request timed out." {
                                                        feedViewModel.errorMessage = "The request timed out. Try Again."
                                                    } else {
                                                        feedViewModel.errorMessage = error.localizedDescription
                                                    }
                                            }
                                        }
                                    } else {
                                        print("video is too large")
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
