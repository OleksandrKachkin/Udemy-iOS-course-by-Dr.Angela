//
//  Question.swift
//  08.Quizzler-iOS13
//
//  Created by Oleksandr Kachkin on 08.02.2022.
//

import Foundation

struct Question {
  let text: String
  let answer: String
  
  init(q: String, a: String) {
    text = q
    answer = a
  }
}
