//
//  generateMusic.swift
//  noissy
//
//  Created by Mert Guldu on 4/12/24.
//

import Foundation
import SwiftUI

func generateMusic(encodedData: String, userID: String, feedViewModel: FeedViewModel) {
    NetworkService.shared.sendVideoData(videoData: encodedData, userID: userID) {(result) in
        switch result {
        case .success(let music):
            print("backend result is successfull")
            feedViewModel.generatedMusic = music
            feedViewModel.newMerge = true
            
            withAnimation {
                feedViewModel.currentView = .EDITING
                feedViewModel.isTaskCompleted = true
                feedViewModel.currentTask = false
            }
        case .failure(let error):
            print("error:", error.localizedDescription)
            feedViewModel.currentTask = false
            feedViewModel.isErrorOccured = true
            if error.localizedDescription == "The request timed out." {
                feedViewModel.errorMessage = "The request timed out. Try Again."
            } else {
                feedViewModel.errorMessage = "An Unknown Error Occurred. Please Try Again Later."
                print(error.localizedDescription)
            }
        }
    }
}
