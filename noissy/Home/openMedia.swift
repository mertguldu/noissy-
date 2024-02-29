//
//  openMedia.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import AVKit
import PhotosUI
import SwiftUI

struct openMedia: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var selectedItem: PhotosPickerItem?
    @State private var isNavigate = false
    @State var data : NSData? = nil
    
    var body: some View {
        VStack {
            NavigationStack {
                PhotosPicker(selection: $selectedItem, matching: .videos){
                    logo()
                }
                    .onChange(of: selectedItem) { _ in
                        Task {
                            do {
                                if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
                                    isNavigate = true
                                    
                                    data = NSData(contentsOf: movie.url)!
                                    feedViewModel.selectedContent = data
                                    feedViewModel.isTaskCompleted = true
                                    feedViewModel.add(contentData: data! as Data)
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    .padding(.top, -200)
                    .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
                    //.navigationDestination(isPresented: $isNavigate) {
                      //  singleFeedView(feedViewModel: feedViewModel, contentData: data)
                    //}
            }
        }
    }
}

#Preview {
    openMedia(feedViewModel: FeedViewModel())
}

