//
//  RechordViewModel.swift
//  RechordCodingChallenge
//
//  Created by Dan Wartnaby on 11/04/2022.
//
import SwiftUI
import Foundation
import AudioKit

class RecordViewModel: ObservableObject {
    
    private(set) var engine: AudioEngine
    private(set) var mixer: Mixer
    private(set) var player: AudioPlayer?
    @Published var showFileBrowser: Bool = false
    @Published var isPlaying: Bool = false
     var selectedFileName: String = ""
    
    init(audioEngine: AudioEngine = AudioEngine(), audioMixer: Mixer = Mixer()) {
        engine = audioEngine
        mixer = audioMixer
    }
        
    func loadAudio(from url: URL) {
        player = AudioPlayer(url: url, buffered: false)
        guard let player = player else { return }
        mixer.addInput(player)
    }
}

// MARK: - Actions Methods
extension RecordViewModel {
    
    func startORStop() {
        if isPlaying {
            play()
        } else {
            stop()
        }
    }

    func play() {
        player?.play()
    }
    
    func stop() {
        player?.stop()
    }
        
    func startEngine() {
        engine.output = mixer
        
        do {
            try engine.start()
            mixer.start()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func stopEngine() {
        mixer.stop()
        engine.stop()
    }
}
