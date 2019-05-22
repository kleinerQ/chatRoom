//
//  ChatMessageBoardSentTableViewCell.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/5/21.
//  Copyright © 2019 Yen. All rights reserved.
//

import UIKit

class ChatMessageBoardSentTableViewCell: UITableViewCell {
    @IBOutlet weak var timeStampLb: UILabel!
    
    
    @IBOutlet weak var messageLb: UILabel!
    
    
    @IBOutlet weak var bubbleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let image = UIImage(named: "bubble_sent") else {
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
