//
//  feedView.swift

import SwiftUI

struct feedView: View {
    @State var scrollTo: Int? = nil
    var feedViewModel: FeedViewModel
    var CoreVM: CoreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(CoreVM.savedContents.indices, id: \.self){ index in
                        if let contentData = CoreVM.savedContents[index].content {
                            let content = UIImage(data: contentData)
                            singleFeedView(feed: Feed(content: content!), feedViewModel: feedViewModel)
                                .id(index)
                        }
                    }.onAppear(perform: {
                        if let position = scrollTo {
                            scrollView.scrollTo(position)
                        }
                    })
                }
            }.scrollTargetBehavior(.paging)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.1, green: 0.0, blue: 0.1))
        }
    }
}

#Preview {
    feedView(feedViewModel: FeedViewModel())
}
