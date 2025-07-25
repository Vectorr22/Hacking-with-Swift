//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Victor Manuel Tijerina Garnica on 19/04/25.
//

import Foundation
import SwiftUI

struct FlagImage: View {
    let number: Int
    let countries: Array<String>
    let buttonPressedAction: () -> Void
    var body: some View{
        Button(action: buttonPressedAction, label: {
            Image(countries[number])
        })
        .clipShape(.capsule)
        .shadow(radius: 50)
    }
}
