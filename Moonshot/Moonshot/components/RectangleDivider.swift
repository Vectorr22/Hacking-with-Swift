//
//  RectangleDivider.swift
//  Moonshot
//
//  Created by Victor Manuel Tijerina Garnica on 06/08/25.
//

import SwiftUI

struct RectangleDivider: View {
    let background: Color
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(background)
            .padding(.vertical)
    }
}

#Preview {
    RectangleDivider(
        background: .lightBackground)
}
