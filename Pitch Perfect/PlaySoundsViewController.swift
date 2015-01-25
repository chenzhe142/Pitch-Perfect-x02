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
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
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
    }

    @IBAction func QuickSoundPlay(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.volume = 1.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
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
