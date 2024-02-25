//
//  noissy.swift

import SwiftUI

struct noissy: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @ObservedObject var CoreDataVM: CoreDataViewModel

    var body: some View {
        NavigationStack {
                ZStack {
                    noissyHeader()
                    containerView(feedViewModel: feedViewModel)
                        .padding(.top, 70)
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(mainColor)
            }
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    noissy(feedViewModel: FeedViewModel(), CoreDataVM: CoreDataViewModel())
       
}
