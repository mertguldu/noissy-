//
//  libraryFeedPreview.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct libraryFeedPreview: View {
    var index: Int?
    var feedViewModel: FeedViewModel
    var CoreDataVM: CoreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        CustomNavigationLink(title: "") {
            feedView(scrollTo: index, feedViewModel: feedViewModel, CoreVM: CoreDataVM)
        } label: {
            if let i = index {
                if let uiimage = UIImage(data: CoreDataVM.savedContents[i].content!) {
                    Image(uiImage: uiimage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                }
            }
        }
    }
}

#Preview {
    libraryFeedPreview(feedViewModel: FeedViewModel())
}
