//
//  ChatRoomViewController.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/4/26.
//  Copyright © 2019年 Yen. All rights reserved.
//

import UIKit
let Original_FunctionBoardHeight = 200.0
class ChatRoomViewController: UIViewController {
    

    enum MESSAGEMODE:String {
        case SEND = "SEND",
        RECIEVE = "RECIEVE"
        
    }
    deinit {
        print("AA")
    }
    var sentMode:MESSAGEMODE = .SEND
    let messageBoardMaxWidth = (UIScreen.main.bounds.width * 0.5)
    var shouldScrollToLastRow = false
    @IBOutlet weak var messageInputStackView: UIStackView!
    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var heightContraintOfFunctionBoard: NSLayoutConstraint!
    @IBOutlet weak var messageBlackBoardTableView: UITableView!
    @IBOutlet weak var messageInputBoxView: UITextField!
    
    
    /// hide StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // call this func to force preferredStatusBarStyle to be read again.
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventKeyboard()
        self.heightContraintOfFunctionBoard.constant = CGFloat(Original_FunctionBoardHeight)
        self.messageBlackBoardTableView.delegate = self
        self.messageBlackBoardTableView.dataSource = self
        self.messageBlackBoardTableView.register(UINib(nibName: "ChatMessageBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatMessageBoardTableViewCell")
        self.messageBlackBoardTableView.register(UINib(nibName: "ChatMessageBoardSentTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatMessageBoardSentTableViewCell")
        self.addStickyButtonToTableView(tableView: self.messageBlackBoardTableView)
        self.shouldScrollToLastRow = true
        let headerNib = UINib.init(nibName: "MessageBlackBoardHeaderView", bundle: Bundle.main)
        messageBlackBoardTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "MessageBlackBoardHeaderView")
        self.modalPresentationCapturesStatusBarAppearance = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.shouldScrollToLastRow && ChatDataManagement.shared.messageData.count > 0{
            self.shouldScrollToLastRow = false
            self.tableViewContentOffsetToLast(tableView: self.messageBlackBoardTableView)
            self.tableViewScrollToLast(tableView: self.messageBlackBoardTableView)
        }
    }

    // MARK: buttton Actions
    // keyborad "go" button action // now is send message
    @IBAction func keyBoardGoAction(_ sender: Any) {
        self.sendMessageButton.sendActions(for: .allEvents)
    }
    // unfold the functionBoard
    @IBAction func unfoldFunctionBoardButtonAction(_ sender: UIButton) {
        self.messageInputBoxView.resignFirstResponder()
        if self.heightContraintOfFunctionBoard.constant == 0 {
            self.heightContraintOfFunctionBoard.constant = CGFloat(Original_FunctionBoardHeight)
            self.checkLastIndexVisibleAndtableViewContentOffsetToLast(tableView: self.messageBlackBoardTableView)
        }else{
            self.heightContraintOfFunctionBoard.constant = 0
            self.checkLastIndexVisibleAndtableViewContentOffsetToLast(tableView: self.messageBlackBoardTableView)
        }
        
    }
    
    
    @IBAction func recieveButtonAction(_ sender: UIButton) {
        self.sentMode = .RECIEVE
        let inputString = self.messageInputBoxView.text ?? ""
        //exclude ""
        if self.stringSpaceCheck(str: inputString){
            let message = ChatDataManagement.Message(context: inputString, owner: self.sentMode.rawValue)
            ChatDataManagement.shared.messageData.append(message)
            self.messageBlackBoardTableView.reloadData()
            self.tableViewScrollToLast(tableView: self.messageBlackBoardTableView)
            self.messageInputBoxView.text = ""
        }else{
            //do nothing
        }
    }
    
    @IBAction func sendMessageButton(_ sender: UIButton) {
        self.sentMode = .SEND
        let inputString = self.messageInputBoxView.text ?? ""
        //exclude ""
        if self.stringSpaceCheck(str: inputString){

            let message = ChatDataManagement.Message(context: inputString, owner: self.sentMode.rawValue)
            ChatDataManagement.shared.messageData.append(message)
            self.messageBlackBoardTableView.reloadData()
            self.tableViewScrollToLast(tableView: self.messageBlackBoardTableView)
            self.messageInputBoxView.text = ""
        }else{
            //do nothing
        }
        
    }

    private func stringSpaceCheck(str:String)->Bool{
        return !str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
}



// MARK: - tableViewDelegate
extension ChatRoomViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MessageBlackBoardHeaderView") as! MessageBlackBoardHeaderView
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatDataManagement.shared.messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if ChatDataManagement.shared.messageData[indexPath.row].owner == MESSAGEMODE.RECIEVE.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageBoardTableViewCell", for: indexPath) as! ChatMessageBoardTableViewCell
            cell.messageLb.text = ChatDataManagement.shared.messageData[indexPath.row].context
            cell.messageLb.preferredMaxLayoutWidth = self.messageBoardMaxWidth
            
            // assign timeStamp Text
            let timeInterval:TimeInterval = Date().timeIntervalSince1970
            let date = Date(timeIntervalSince1970: timeInterval)
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm"
            cell.timeStampLb.text = dateformatter.string(from: date)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageBoardSentTableViewCell", for: indexPath) as! ChatMessageBoardSentTableViewCell
            cell.messageLb.text = ChatDataManagement.shared.messageData[indexPath.row].context
            cell.messageLb.preferredMaxLayoutWidth = self.messageBoardMaxWidth
            
            // assign timeStamp Text
            let timeInterval:TimeInterval = Date().timeIntervalSince1970
            let date = Date(timeIntervalSince1970: timeInterval)
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm"
            cell.timeStampLb.text = dateformatter.string(from: date)
            return cell
        }

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.messageInputBoxView.resignFirstResponder()
    }
    
    
    /// scroll to the last row
    func tableViewScrollToLast(tableView: UITableView){
        self.view.layoutIfNeeded()
        let lastIndexpath = self.lastIndexpath(tableView: tableView)
        //exclude IndexPath(row: 0, section: 0)
        if lastIndexpath != IndexPath(row: 0, section: 0) {
            tableView.scrollToRow(at: lastIndexpath, at: UITableView.ScrollPosition.bottom, animated: false)
        }
        
    }
    
    /// find the last indexPath
    func lastIndexpath(tableView: UITableView) -> IndexPath {
        let section = max(tableView.numberOfSections - 1, 0)
        let row = max(tableView.numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
    
    /// scrollOffset to the last row
    func checkLastIndexVisibleAndtableViewContentOffsetToLast(tableView: UITableView){
        let lastIndexPath = self.lastIndexpath(tableView: tableView)
        for visibleIndexPath in (tableView.indexPathsForVisibleRows)!{
            if visibleIndexPath == lastIndexPath{
                //must do layoutIfNeeded, or it won't scroll
                self.view.layoutIfNeeded()
                let offsetPoint = CGPoint(x: 0 , y: max(tableView.contentSize.height - tableView.frame.height, 0 ))
                tableView.setContentOffset(offsetPoint, animated: false)
            }
        }
        
    }
    
    
    func tableViewContentOffsetToLast(tableView: UITableView){
        //must do layoutIfNeeded, or it won't scroll
        self.view.layoutIfNeeded()
        let offsetPoint = CGPoint(x: 0 , y: max(tableView.contentSize.height - tableView.frame.height, 0 ))
        tableView.setContentOffset(offsetPoint, animated: false)
    }
}



// MARK: - NSNotification keyboard
extension ChatRoomViewController{
    
    /// add notification of keyboard event
    public func eventKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUIKeyboardWillHide), name: UIWindow.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onUIKeyboardWillShow), name: UIWindow.keyboardWillShowNotification, object: nil)
    }
    
    /// Invoked as keyboar will Show
    @objc func onUIKeyboardWillShow(notification: NSNotification){
        let kbHeight = self.getKeyoardHeight(notification)
        self.heightContraintOfFunctionBoard.constant = CGFloat(kbHeight)
        self.checkLastIndexVisibleAndtableViewContentOffsetToLast(tableView: self.messageBlackBoardTableView)
    }
    
    /// Invoked as keyboar will hide
    @objc func onUIKeyboardWillHide(notification: NSNotification){
        
        self.heightContraintOfFunctionBoard.constant = 0
    }
     
    public func getKeyoardHeight(_ notification: NSNotification)->Int{
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let value = userInfo.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
        var height:Int = 0
        if let keyboardRec = (value as AnyObject).cgRectValue{
            height = Int(keyboardRec.size.height)
        }
        return height
    }
}


// MARK: - dismissBtn
extension ChatRoomViewController{
    
    func addStickyButtonToTableView(tableView:UITableView){
        let stickyBtn = UIButton(frame: CGRect(x: 0, y: 0, width:  0, height: 0))
        stickyBtn.backgroundColor = UIColor.red
        stickyBtn.setTitle("<", for: .normal)
        stickyBtn.addTarget(self, action: #selector(stickyBtnAction), for: .touchUpInside)
        self.view.addSubview(stickyBtn)
        stickyBtn.translatesAutoresizingMaskIntoConstraints = false
        let centerYContraint = NSLayoutConstraint(item: stickyBtn, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.messageInputStackView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: -UIScreen.main.bounds.height / 4)
        let trailingConstraint = NSLayoutConstraint(item: stickyBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)

        let widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: stickyBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.05, constant: 0);

        let heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: stickyBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.15, constant: 0);

        self.view.addConstraints([centerYContraint,trailingConstraint,heightConstraint,widthConstraint])
    }
    
    @objc func stickyBtnAction(sender: UIButton!) {
        print("Button tapped")
        self.dismiss(animated: false, completion: nil)
    }
    
    class CustomUIWindow: UIWindow {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            layer.contents = UIImage(named: "ball1")?.cgImage
            windowLevel = UIWindow.Level.alert + 1
            
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
            pan.delaysTouchesBegan = true
            addGestureRecognizer(pan)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func handlePanGesture(pan: UIPanGestureRecognizer){
            
            let translation = pan.translation(in: UIApplication.shared.keyWindow)
            let originalCenter = center
            center = CGPoint(x:originalCenter.x + translation.x, y:originalCenter.y + translation.y)
            pan.setTranslation(CGPoint.zero, in: UIApplication.shared.keyWindow)
        }
        
    }
    
}
