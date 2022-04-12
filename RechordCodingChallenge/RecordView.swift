//
//  RechordView.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//

import SwiftUI
import AudioKit

struct RecordView: View {
    
    @ObservedObject var viewModel: RecordViewModel
        
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text(Constants.recordTest)
                    .font(.headline)
                Text(Constants.multiLineText).multilineTextAlignment(.leading).font(.body)
                
                VStack(spacing: 10) {
                    Text(viewModel.selectedFileName)
                    Button(Constants.browseFile) {
                        viewModel.showFileBrowser = true
                    }
                    .buttonStyle(ThemeButtonStyle())
                    Button(Constants.loadTestLoop) {
                        loadFile()
                    }
                    .buttonStyle(ThemeButtonStyle())
                    Button(viewModel.isPlaying ? Constants.stop : Constants.play) {
                        viewModel.isPlaying.toggle()
                        viewModel.startORStop()
                    }
                    .buttonStyle(ThemeButtonStyle())
                }
            }
            .padding(30)
            .onAppear {
                viewModel.startEngine()
            }
            .fileImporter(
                isPresented: $viewModel.showFileBrowser,
                allowedContentTypes: [.audio],
                allowsMultipleSelection: false
            ) { result in
                loadAudioFromFile(result: result)
            }
        }
    }
    
    private func loadAudioFromFile(result: Result<[URL], Error>) {
        
        do {
            guard let file = try result.get().first else {
                return
            }
            viewModel.selectedFileName = file.absoluteString
            viewModel.loadAudio(from: file)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func loadFile() {
        let file = Bundle.main.url(forResource: "loop", withExtension: "wav")!
        viewModel.loadAudio(from: file)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(viewModel: RecordViewModel())
    }
}
