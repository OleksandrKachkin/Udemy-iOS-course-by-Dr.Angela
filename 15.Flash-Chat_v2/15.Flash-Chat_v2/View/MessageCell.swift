//
//  MessageCell.swift
//  15.Flash-Chat_v2
//
//  Created by Oleksandr Kachkin on 11.03.2022.
//

import UIKit

class MessageCell: UITableViewCell {

  @IBOutlet weak var messageBubble: UIView!
  @IBOutlet weak var rightImageView: UIImageView!
  @IBOutlet weak var leftImageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()

    messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 2
  
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
