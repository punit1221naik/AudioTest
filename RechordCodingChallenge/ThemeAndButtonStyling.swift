//
//  ThemeAndButtonStyling.swift
//  RechordCodingChallenge
//
//  Created by punit naik on 12/04/22.
//

import SwiftUI

struct ThemeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(12)
            .foregroundColor(Constants.colorConstants.foregroundColor)
            .background(Constants.colorConstants.backGroundColor)
            .cornerRadius(8)
    }
}
