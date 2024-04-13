//
//  Preference Keys.swift
//  noissy
//
//  Created by Mert Guldu on 4/12/24.
//

import Foundation
import SwiftUI

struct ScrollOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
