//
//  PreferenceKeys.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI
import Foundation

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

