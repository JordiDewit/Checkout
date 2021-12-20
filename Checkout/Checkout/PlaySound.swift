//
//  PlaySound.swift
//  Checkout
//
//  Created by Jordi Dewit on 20/12/2021.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play sound file.")
        }
    }
        
}
