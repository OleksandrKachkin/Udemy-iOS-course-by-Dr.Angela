//
//  CalculatorViewController.swift
//  12.Tipsy-iOS13
//
//  Created by Oleksandr Kachkin on 15.02.2022.
//

import UIKit

class CalculatorViewController: UIViewController {
  
  
  @IBOutlet weak var billTextField: UITextField!
  @IBOutlet weak var zeroPctButton: UIButton!
  @IBOutlet weak var tenPctButton: UIButton!
  @IBOutlet weak var twentyPctButton: UIButton!
  @IBOutlet weak var splitNumberLabel: UILabel!
  
  
  var tip = 0.1
  var numberOfPeople = 2
  var billTotal = 0.0
  var finalResult = "0.0"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    billTextField.keyboardType = .decimalPad
    
  }
  
  @IBAction func tipChanged(_ sender: UIButton) {
    
    billTextField.endEditing(true)
    
    zeroPctButton.isSelected = false
    tenPctButton.isSelected = false
    twentyPctButton.isSelected = false
    sender.isSelected = true
    
    let buttonTitle = sender.currentTitle!
    let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
    let buttonTitleAsANumber = Double(buttonTitleMinusPercentSign)!
    tip = buttonTitleAsANumber / 100
    
  }
  
  @IBAction func stepperValueChanged(_ sender: UIStepper) {
    splitNumberLabel.text = String(format: "%.0f", sender.value)
    numberOfPeople = Int(sender.value)
  }
  
  @IBAction func calculatePressed(_ sender: UIButton) {
    
    let bill = billTextField.text!
    if bill != "" {
      billTotal = Double(bill)!
      let result = billTotal * (1 + tip) / Double(numberOfPeople)
      finalResult = String(format: "%.2f", result)
    }
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let controller = storyboard.instantiateViewController(withIdentifier: "ResultsVC") as? ResultsViewController {
      controller.result = finalResult
      controller.people = numberOfPeople
      controller.tips = Int(tip * 100)
      present(controller, animated: true)
    }
    
    
    
  }
}
