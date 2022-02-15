//
//  CalculatorBrain.swift
//  10.BMI-Calculator-iOS13
//
//  Created by Oleksandr Kachkin on 11.02.2022.
//

import UIKit

struct CalculatorBrain {
  
  var bmi: BMI?
  
  func getBMIValue() -> String {
    let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? "0.0")
    return bmiTo1DecimalPlace
  }
  
  mutating func calculateBMI(height: Float, weight: Float) {
    let bmiValue = weight / pow(height, 2)
    if bmiValue < 18.5 {
      bmi = BMI(value: bmiValue, advice: "Кушайте больше булочек", color: .blue)
    } else if bmiValue < 24.9 {
      bmi = BMI(value: bmiValue, advice: "Идеальные пропорции", color: .green)
    } else {
      bmi = BMI(value: bmiValue, advice: "Пора на диету", color: .red)
    }
  }
  
  func getAdvice() -> String {
    return bmi?.advice ?? "Данные отсутствуют"
  }
  
  func getColor() -> UIColor {
    return bmi?.color ?? .white
  }
  
}
