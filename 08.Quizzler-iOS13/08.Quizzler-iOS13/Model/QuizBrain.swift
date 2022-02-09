//
//  QuizBrain.swift
//  08.Quizzler-iOS13
//
//  Created by Oleksandr Kachkin on 09.02.2022.
//

import Foundation

struct QuizBrain {
  
  let quiz = [
    Question(q: "Кровь слизняка зеленая.", a: "True"),
    Question(q: "Примерно четверть человеческих костей находится в ногах.", a: "True"),
    Question(q: "Общая площадь поверхности двух легких человека составляет примерно 70 квадратных метров.", a: "True"),
    Question(q: "В Западной Вирджинии, США, если вы случайно сбили своей машиной животное, вы можете взять его домой, чтобы поесть.", a: "True"),
    Question(q: "В Лондоне, Великобритания, если вам случится умереть в здании парламента, технически вы имеете право на государственные похороны, потому что это здание считается слишком священным местом.", a: "False"),
    Question(q: "В Португалии запрещено мочиться в океан.", a: "True"),
    Question(q: "Можно вести корову вниз по лестнице, но не вверх по лестнице.", a: "False"),
    Question(q: "Первоначально Google назывался 'BackRub'.", a: "True"),
    Question(q: "Девичья фамилия матери Buzz Aldrin была 'Moon'.", a: "True"),
    Question(q: "Самый громкий звук, издаваемый любым животным, составляет 188 децибел. Это животное — синий кит.", a: "True"),
    Question(q: "Ни один квадратный кусок сухой бумаги нельзя сложить пополам более 8 раз.", a: "True"),
    Question(q: "Шоколад влияет на сердце и нервную систему собаки.  100 грамм достаточно, чтобы убить маленькую собаку.", a: "True")
  ]
  
  var questionNumber = 0
  var score = 0
  
  mutating func checkAnswer(_ userAnswer: String) -> Bool {
    if userAnswer == quiz[questionNumber].answer {
      score += 1
      return true
    } else {
      return false
    }
  }
  
  func getScore() -> Int {
    return score
  }
  
  func getQuestionText() -> String {
    return quiz[questionNumber].text
  }
  
  func getProgress() -> Float {
    let progress = Float(questionNumber + 1) / Float(quiz.count)
    return progress
  }
  
  mutating func nextQuestion() {
    if questionNumber + 1 < quiz.count {
      questionNumber += 1
    } else {
      questionNumber = 0
      score = 0
    }
  }
}
