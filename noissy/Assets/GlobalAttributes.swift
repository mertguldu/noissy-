//
//  GlobalAttributes.swift
//  noissy
//
//  Created by Mert Guldu on 4/12/24.
//

import Foundation
import UIKit

let exampleVideoURL: URL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")!
let exampleAudioURL: URL = URL(string: "https://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/theme_01.mp3")!

let width = (UIScreen.current?.bounds.width ?? 0)
let height = (UIScreen.current?.bounds.height ?? 0)

let thumbNailWidth = width * 0.06
let numberOfThumbNail = 20
