//
//  VideoMenu.swift
//  noissy
//
//  Created by Mert Guldu on 3/2/24.
//

import SwiftUI

struct VideoMenu: View {
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing:20) {
                ShareButton()
                if let id = feedID {
                    DeleteButton(feedID: id, feedViewModel: feedViewModel)
                }
                MoreActionButton()
            }
            .padding()
        }
    }
}

#Preview {
    VideoMenu(feedViewModel: FeedViewModel())
}
