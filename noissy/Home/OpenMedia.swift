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
                                    let data = NSData(contentsOf: movie.url)!
                                    let cgimage = await generateImageFromVideo(videoUrl: movie.url)
                                    let imageData = UIImage(cgImage: cgimage).pngData()
                                    
                                    feedViewModel.imagePreviewData = imageData
                                    feedViewModel.selectedMovie = data.base64EncodedString()
                                    feedViewModel.newMerge = true
                                    feedViewModel.currentTask = true
                                    
                                    NetworkService.shared.sendVideoData(videoData: data.base64EncodedString()) {(result) in
                                        switch result {
                                        case .success(let musicData):
                                            print("backend result is successfull")
                                            feedViewModel.musicDataString = musicData
                                            
                                            feedViewModel.isTaskCompleted = true
                                            
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                        }
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
                    Logo()
                        .padding(.top, -200)
                }
            }
        }
    }
}

#Preview {
    OpenMedia(feedViewModel: FeedViewModel())
}
