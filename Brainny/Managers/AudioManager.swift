//
//  AudioManager.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.11.2024.
//

import Foundation
import AVFoundation

class AudioManager {
    static var shared = AudioManager()
    var player: AVAudioPlayer?
    var touchedPlayer: AVAudioPlayer?
    var correctPlayer: AVAudioPlayer?
    var wrongPlayer: AVAudioPlayer?
    var winPlayer: AVAudioPlayer?
    
    init() {
        prepare()
    }
    
    func prepare() {
        //  player = prepareMusic(name: <#T##String#>)
        touchedPlayer = prepareSound(name: "touch")
        correctPlayer = prepareSound(name: "correct")
        wrongPlayer = prepareSound(name: "wrong")
        winPlayer = prepareSound(name: "win")
    }
    
    private func prepareMusic(name: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name,
                                        withExtension: "mp3") else { return nil }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            var player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player.volume = UserDefaultsValues.volume
            player.numberOfLoops = -1
            return player
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func prepareSound(name:String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name,
                                        withExtension: "mp3") else { return nil }
        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
            var player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player.volume = 0.9
            player.numberOfLoops = 0
            return player
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func changeMusicVolume() {
        player?.volume = UserDefaultsValues.volume
    }
    
    
    func playBackgroundMusic() {
        //  if !UserDefaultsValues.musicOff {
        player?.play()
        // }
    }
    
    
    func playTouchedSound() {
        if !UserDefaultsValues.soundOff {
            touchedPlayer?.play()
        }
    }
    
    func playWinSound() {
        if !UserDefaultsValues.soundOff {
            winPlayer?.play()
        }
    }
    
    func playCorrectSound() {
        if !UserDefaultsValues.soundOff {
            correctPlayer?.play()
        }
    }
    
    func playWrongSound() {
        if !UserDefaultsValues.soundOff {
            wrongPlayer?.play()
        }
    }
    
    func stopPlaying() {
        player?.stop()
    }
    
}



