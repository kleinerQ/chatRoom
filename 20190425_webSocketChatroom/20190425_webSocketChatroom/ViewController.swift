//
//  ViewController.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/4/25.
//  Copyright © 2019年 Yen. All rights reserved.
//

import UIKit
class ViewController: UIViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func clearChatDataButtonAction(_ sender: Any) {
        ChatDataManagement.shared.renew()
    }
    
    @IBAction func showChatBtnAction(_ sender: Any) {
        let vc = ChatRoomViewController()
        self.present(vc, animated: false, completion: nil)
    }
    

}

