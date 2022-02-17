//
//  ResultsViewController.swift
//  12.Tipsy-iOS13
//
//  Created by Oleksandr Kachkin on 17.02.2022.
//

import UIKit

class ResultsViewController: UIViewController {

  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var settingsLabel: UILabel!
  
  var result = "0.0"
  var people = 2
  var tips = 10
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    totalLabel.text = result
    settingsLabel.text = "Split between \(people) people, with \(tips)% tip."
    }

  
  @IBAction func recalculatePressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
}
