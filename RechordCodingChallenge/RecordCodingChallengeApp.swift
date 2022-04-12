//
//  RechordCodingChallengeApp.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//

import SwiftUI

@main
struct RecordCodingChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            RecordView(viewModel: RecordViewModel())
        }
    }
}
