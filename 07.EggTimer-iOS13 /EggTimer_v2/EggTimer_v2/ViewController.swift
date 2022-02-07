//
//  ViewController.swift
//  EggTimer_v2
//
//  Created by Oleksandr Kachkin on 02.02.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var eggsTitleLabel: UILabel!
  @IBOutlet weak var progressBar: UIProgressView!
  var player: AVAudioPlayer!
  let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 7]
  var timer = Timer()
  var totalTime = 0
  var secondsPassed = 0
  
  @IBAction func hardnessSelected(_ sender: UIButton) {
    
    timer.invalidate() // Обновить / обнулить наш таймер
    let hardness = sender.currentTitle!
    totalTime = eggTimes[hardness]!
    
    progressBar.progress = 0.0
    secondsPassed = 0
    eggsTitleLabel.text = hardness
    
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    
  }
  
  @objc func updateTimer() {
    if secondsPassed < totalTime {
      secondsPassed += 1
      progressBar.progress = Float(secondsPassed) / Float(totalTime)
    } else {
      timer.invalidate()
      eggsTitleLabel.text = "DONE!"
      playSound(soundName: "alarm_sound")
      
    }
  }
  
  func playSound(soundName: String) {
    let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
  }
}
