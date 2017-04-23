//
//  RecorSoundsViewController.swift
//  PitchPerfect
//
//  Created by Satveer Singh on 16/04/17.
//  Copyright © 2017 Satveer Singh. All rights reserved.
//

import UIKit
import AVFoundation
class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!  //Create variable of type AVAudioRecoder
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        
    }

    
    // MARK: recordAudio method
    @IBAction func recordAudio(_ sender: Any) {
        var permission = false
        switch AVAudioSession.sharedInstance().recordPermission() {
        case AVAudioSessionRecordPermission.granted:
            permission = true
        case AVAudioSessionRecordPermission.denied:
            permission = false
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                if granted {
                    permission = true
                } else {
                    permission = false
                }
            })
        default:
            break
        }
        
        if permission {
        
        recordingLabel.text = "Recording in progress"
        recordingButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        
        //Start recoring with AVAudioRecorder class
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        }else {
            showAlert(Alerts.RecordingDisabledTitle, message: Alerts.RecordingDisabledMessage, viewController: self)

        }
    }
    
    // MARK: stopRecoding method
    @IBAction func stopRecording(_ sender: Any) {
        recordingButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: AVAudioRecorderDelegate method implementation
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == true {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else {
            print("Recording failed")
        }
    }
    // MARK: Prepare segue to navigate to PlaySoundsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            playSoundsVC.recordedAudioURL = audioRecorder.url
        }
    }
}

