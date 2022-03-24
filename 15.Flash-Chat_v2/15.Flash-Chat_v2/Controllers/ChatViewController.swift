//
//  ChatViewController.swift
//  15.Flash-Chat
//
//  Created by Oleksandr Kachkin on 23.02.2022.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var messageTextfield: UITextField!
  
  let db = Firestore.firestore()
  
  var messages: [Message] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    
    //Указать название текущего ВК
    title = K.appName
    //Спрятать кнопку "назад" на текущем ВК
    navigationItem.hidesBackButton = true
    
    // Register NIB with my tableView
    tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    
    // method loadMessages for to pull up all of the current data that's inside our database.
    // And then we're going to use it to populate our tableview.
    loadMessages()
  }
  
  func loadMessages() {
    
    db.collection(K.FStore.collectionName)
      .order(by: K.FStore.dateField)
      .addSnapshotListener { (querySnapshot, error) in
      
      self.messages = []
      
      if let err = error {
        print("There was an issue retrieving data from a Firestore. \(err.localizedDescription)")
      } else {
        if let snapshotDocuments = querySnapshot?.documents {
          for doc in snapshotDocuments {
            let data = doc.data()
            if let sender = data[K.FStore.senderField] as? String,
               let messageBody = data[K.FStore.bodyField] as? String {
              let newMessage = Message(sender: sender, body: messageBody)
              self.messages.append(newMessage)
              
              // Когда вы пытаетесь манипулировать UI (обновить tableView) и находитесь внутри замыкания (все что находится внутри замыкания выполняется в бэкграунде) -> хорошей идеей будет получить доступ к основной очереди.
              DispatchQueue.main.async {
                self.tableView.reloadData()
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
              }
            }
          }
        }
      }
    }
    
  }
  
  @IBAction func sendButtonPressed(_ sender: UIButton) {
    // Add data to Firestore
    if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
      db.collection(K.FStore.collectionName).addDocument(data: [
        K.FStore.senderField: messageSender,
        K.FStore.bodyField: messageBody,
        K.FStore.dateField: Date().timeIntervalSince1970
      ]) { error in
        if let err = error {
          print("There was an issue saving data to Firestore \(err.localizedDescription)")
        } else {
          print("Successfully saved data.")
          
          DispatchQueue.main.async {
            self.messageTextfield.text = ""
          }
        }
      }
    }
  }
  
  @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
    do {
      try Auth.auth().signOut()
      // Выйти на корневой ВК
      navigationController?.popToRootViewController(animated: true)
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
  }
}

extension ChatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let message = messages[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
    cell.label.text = message.body
    
    // This is a message from the current user
    if message.sender == Auth.auth().currentUser?.email {
      cell.leftImageView.isHidden = true
      cell.rightImageView.isHidden = false
      cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
      cell.label.textColor = UIColor(named: K.BrandColors.purple)
    }
    
    // This is a message from the another sender
    else {
      cell.leftImageView.isHidden = false
      cell.rightImageView.isHidden = true
      cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
      cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
    }
    
    return cell
  }
}


