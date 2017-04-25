//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Satveer Singh on 21/04/17.
//  Copyright © 2017 Satveer Singh. All rights reserved.
//

import UIKit
import AVFoundation
class PlaySoundsViewController: UIViewController {
    var recordedAudioURL: URL!
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthVaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioFile: AVAudioFile!  //Variable of type AVAudioFile class
    var audioEngine : AVAudioEngine! // Variable of type AVAudioEngine to access node and change sound pitch
    var audioPlayerNode : AVAudioPlayerNode! // Variable of type AVAudioPlayeNode to set different sound pitch
    var stopTimer : Timer!
    
    // MARK: ENUM to access tag value of different button
    enum ButtonType :Int {
        case slow = 0, fast, chimpunk, vader, echo, reverb
    }
    
    
    @IBAction func playSoundForButton(_ sender:UIButton){
        switch (ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chimpunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    // MARK: stopButtonPressed method to stop playing sound
    @IBAction func stopButtonPressed(_ sender:UIButton){
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snailButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        rabbitButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        chipmunkButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        darthVaderButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        echoButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        reverbButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        stopButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        setupAudio()
    }
    @IBOutlet weak var reverbButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
}
