//
//  CustomModifier.swift
//  ViewsAndModifiers
//
//  Created by Victor Manuel Tijerina Garnica on 19/04/25.
//

import Foundation
import SwiftUI

struct CustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundStyle(.cyan)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(CustomModifier())
    }
}
