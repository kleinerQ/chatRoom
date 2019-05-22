//
//  ChatMessageBoardTableViewCell.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/4/26.
//  Copyright © 2019年 Yen. All rights reserved.
//

import UIKit

class ChatMessageBoardTableViewCell: UITableViewCell {
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var messageLb: UILabel!
    @IBOutlet weak var timeStampLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let image = UIImage(named: "bubble_received") else {
            return
        }
        
        self.bubbleImageView.image = image
            .resizableImage(withCapInsets:
                UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)
            .withRenderingMode(.alwaysOriginal)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
}
