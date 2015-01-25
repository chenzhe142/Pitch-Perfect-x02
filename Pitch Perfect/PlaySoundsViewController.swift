//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by 陈喆 on 15/1/22.
//  Copyright (c) 2015年 Zhe Chen. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    // AVAudioEngine
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        if var filePath = NSBundle.mainBundle().pathForResource("test", ofType: "m4a"){
//            var filePathUrl = NSURL.fileURLWithPath(filePath)
//            audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
//            audioPlayer.enableRate = true
//            
//        } else {
//            println("the filePath is empty")
//        }
        stopButton.hidden = true
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        // initialize audioEngine
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SlowSoundPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.hidden = false
        
    }

    @IBAction func QuickSoundPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.volume = 1.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        stopButton.hidden = false
    }
    
    @IBAction func ChipmunkSoundPlay(sender: UIButton) {
        playAudioWithVariablePitch(1000)
        stopButton.hidden = false
    }
    
    
    @IBAction func DarthVaderSoundPlay(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
        stopButton.hidden = false
    }
    
    
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    func playAudioWithVariablePitch(pitch:Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        //attach audioPlayer node to audioEngine
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        //attach pitchEffect to audioEngine
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        //connect node with each other, 
        //then connect with output node
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
