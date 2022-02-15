//
//  ViewController.swift
//  09.Destini-iOS13
//
//  Created by Oleksandr Kachkin on 09.02.2022.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var storyLabel: UILabel!
  @IBOutlet weak var choice1Button: UIButton!
  @IBOutlet weak var choice2Button: UIButton!
  
  var story = StoryBrain()
  


  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateUI()
  }
  
  
  @IBAction func choiceMade(_ sender: UIButton) {
  
    story.nextStory(userChoice: sender.currentTitle!)
    updateUI()
  }
  
  func updateUI() {
    storyLabel.text = story.getStoryText()
    choice1Button.setTitle(story.getChoice1(), for: .normal)
    choice2Button.setTitle(story.getChoice2(), for: .normal)
  }

}
