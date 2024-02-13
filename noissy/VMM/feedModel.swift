//
//  feedModel.swift


import Foundation

struct feedModel<ImageContent> {
    /*
     Model for manipulating the feeds. Only FeedViewModel has access to this logic. Every call to the attributes of this struct is done through FeedViewModel, except for the Feed struct.
     Backbone of the feed logic.
     */
    
    private(set) var contentLibrary: Array<Feed> // Array of selected images/videos(REELs) to show in the library page of the app.
    
    mutating func add(feed: Feed) { // function to add to the library
        contentLibrary.append(feed)
    }
    
    
    struct Feed { //Image, video, REEL - Feed with a content
        let content: ImageContent
    }
    
    
}
