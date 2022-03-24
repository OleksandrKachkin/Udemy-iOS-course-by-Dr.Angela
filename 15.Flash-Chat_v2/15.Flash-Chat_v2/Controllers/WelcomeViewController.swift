//
//  WelcomeViewController.swift
//  15.Flash-Chat
//
//  Created by Oleksandr Kachkin on 23.02.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Спрятать НавБар на стартовой странице
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Показать НавБар после того, как ВК исчезнет
    navigationController?.isNavigationBarHidden = false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    titleLabel.text = "⚡️FlashChat"
    
    titleLabel.text = ""
    var charIndex = 0.0
    let titleText = K.appName
    for latter in titleText {
      Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
        self.titleLabel.text?.append(latter)
      }
      charIndex += 1
    }
  }
}

