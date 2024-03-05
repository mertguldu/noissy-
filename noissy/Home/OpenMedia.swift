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
                                    
                                    feedViewModel.selectedContent = data.base64EncodedString()
                                    
                                    if let imgData = imageData {
                                        
                                        NetworkService.shared.sendVideoData(videoData: data.base64EncodedString()) {(result) in
                                            switch result {
                                            case .success(let musicData):
                                                print("backend result is successfull")
                                                feedViewModel.musicDataString = musicData
                                                feedViewModel.add(imageData: imgData, contentData: data as Data, musicData: Data(base64Encoded: musicData)!)
                                                feedViewModel.isTaskCompleted = true
                                            case .failure(let error):
                                                print(error.localizedDescription)
                                            }
                                        }
                                    } else {print("Unable to save image data")}
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    .padding(.top, -200)
                    //.photosPickerAccessoryVisibility(.hidden, edges: .bottom)
            }
        }
    }
}

#Preview {
    OpenMedia(feedViewModel: FeedViewModel())
}
