//
//  ChatDataManagement.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/5/3.
//  Copyright © 2019年 Yen. All rights reserved.
//

import UIKit

class ChatDataManagement: NSObject {

    static var shared = ChatDataManagement()
    var messageData : [Message] = []
    func renew()
    {
        ChatDataManagement.shared = ChatDataManagement()
        print("Disposed Singleton instance")
    }
    struct Message {
        var context:String
        var owner:String
        init(context:String="", owner:String="") {
            self.context = context
            self.owner = owner
        }
    }
}
