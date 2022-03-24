//
//  Utils.swift
//  15.Flash-Chat_v2
//
//  Created by Oleksandr Kachkin on 11.03.2022.
//

import UIKit

func displayAlert(title: String, message: String, viewController: UIViewController) {
  let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
  let action = UIAlertAction(title: "OK", style: .default, handler: nil)
  alert.addAction(action)
  viewController.present(viewController, animated: true, completion: nil)
}


