//
//  CalculateViewController.swift
//  10.BMI-Calculator-iOS13
//
//  Created by Oleksandr Kachkin on 10.02.2022.
//

import UIKit

class CalculateViewController: UIViewController {
  
  var calculatorBrain = CalculatorBrain()
  
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var heightSlider: UISlider!
  @IBOutlet weak var weightSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func heightSliderChanged(_ sender: UISlider) {
    let height = String(format: "%.2f", sender.value)
    heightLabel.text = "\(height) m"
  }
  
  @IBAction func weightSliderChanged(_ sender: UISlider) {
    let weight = String(format: "%.0f", sender.value)
    weightLabel.text = "\(weight) kg"
  }
  
  
  @IBAction func calculatePressed(_ sender: UIButton) {
    let height = heightSlider.value
    let weight = weightSlider.value
    
    calculatorBrain.calculateBMI(height: height, weight: weight)
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let controller = storyboard.instantiateViewController(withIdentifier: "goToResult") as? ResultViewController {
      controller.bmiValue = calculatorBrain.getBMIValue()
      controller.advice = calculatorBrain.getAdvice()
      controller.color = calculatorBrain.getColor()
      controller.title = "Result"
      self.present(controller, animated: true, completion: nil)
    }
  }
}

