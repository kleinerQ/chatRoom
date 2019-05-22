//
//  ChatViewCellTableViewCell.swift
//  20190425_webSocketChatroom
//
//  Created by Yen on 2019/4/26.
//  Copyright © 2019年 Yen. All rights reserved.
//

import UIKit

enum MessageType{
    
    case ME
    
    case OTHER
    
}

class ChatViewCellTableViewCell: UITableViewCell {

    
    var MAXFLOAT:CGFloat = 0x1.fffffep+127 //文本最大高度
    
    var _icon=UIImageView();
    
    var _times=UILabel();
    
    var _content:UIButton=UIButton(type: UIButton.ButtonType.system) as! UIButton;
    
    var bgImage = UIImageView();
    
    
    var height:CGFloat=0;
    
    
    
    var iconWidth:CGFloat=30;
    
    var cellWidth:CGFloat=10;
    
    var timeWidth:CGFloat=20;
    
    var contentWidthWithBgImage:CGFloat=10;//文本与背景的边界距离
    
    var JLTextFont:UIFont = UIFont(name: "HelveticaNeue", size: 15)!;
    
    
    
    
    
    
    
    
    /**
     * 是否隐藏时间(如果连续多条信息的时间相同，只能有一条信息显示时间)
     */
    
    var hideTime:Bool?;
    
    class ChatMessageModel: NSObject {
        var time:Date! = Date()
        var content:String! = String()
        var sourceId = 7
        var hideTime = 1

    }
    
//    var chatMessageModel:ChatMessageModel?{
//        
//        didSet{
//            
//            self.addSubview(bgImage);
//            
//            self.addSubview(_icon);
//            
//            self.addSubview(_times);
//            
//            self.addSubview(_content);
//            
//            
//            
//            self.backgroundColor = UIColor.clear;
//            
//            
//            
//            //填充内容
//            
//            _icon.image=UIImage(named: "xiaohua");
//            
//            
//            
//            var nf = DateFormatter();
//            
//            nf.date(from: "yyyy-MM-dd HH:mm")
//            
//            _times.text = nf.string(from: chatMessageModel!.time!);
//            
//            _times.textAlignment = NSTextAlignment.center;
//            
//            _times.textColor = UIColor.black
//            
//            
//            
//            //      _content.backgroundColor = UIColor.yellowColor();
//            
//            _content.setTitle(chatMessageModel?.content, for: UIControl.State.normal);
//            
//            _content.setTitleColor(UIColor.black, for: UIControl.State.normal)
//            
//            _content.titleLabel!.numberOfLines = 0;
//            
//            //      _content.titleLabel!.textColor = UIColor.blackColor()
//            
//            _content.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 14);
//            
//            // 设置文本距离UIButton的边距
//            
//            _content.contentEdgeInsets = UIEdgeInsets(top: 1.5*contentWidthWithBgImage, left: 2*contentWidthWithBgImage, bottom: 1.5*contentWidthWithBgImage, right: 2*contentWidthWithBgImage)
//            
//            //填充背景
//            
//            if(chatMessageModel?.sourceId==7){ //7是本人,暂时先写成硬编码
//                
//                bgImage.image = UIImage(named: "meme");
//                
//            }else{
//                
//                bgImage.image = UIImage(named: "other");
//                
//            }
//            
//            
//            var WIDTH = CGFloat(UIScreen.main.bounds.width)
//            var TMP = CGFloat(1.0)
//            //算内容所占的空间
//            
//            if(chatMessageModel?.sourceId==7){
//                
//                
//                
//                //显示时间
//                
//                var MAXWIDTH:CGFloat = WIDTH - 30.0*TMP*2.0 - 50.0*TMP;
//                if(chatMessageModel?.hideTime==1){
//                    
//                    _times.frame = CGRect(x: (MAXWIDTH-150)/2, y: 0, width: 150, height: timeWidth)
//                    
//                }
//                
//                
//                
//                _icon.frame = CGRect(x: WIDTH - 30.0*TMP - 10.0*TMP, y: _times.frame.maxY + 3*TMP, width: iconWidth, height: iconWidth)
//                
//                
//                
//                //文本信息的最大宽度
//                
//                
//                
//                
//                
//                // 文本信息的最大尺寸
//                
//                var textMaxSize = CGSize(width: MAXWIDTH, height: MAXFLOAT)
//                
//                
//                var text:NSString = NSString(string: chatMessageModel!.content!);
//                
//                var dict:NSDictionary = NSDictionary(object:JLTextFont, forKey: NSAttributedString.Key.font as NSCopying)
//                
//                
//                
//                //文本信息真实尺寸
//                
//                var textRealSize = text.boundingRect(with: textMaxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dict as [NSObject : AnyObject] as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], context: nil);
//                
//                
//                
//                _content.frame = CGRect(x: WIDTH-textRealSize.width-iconWidth-55*IMP, y: CGRectGetMaxY(_icon.frame)-iconWidth, width: textRealSize.width+4*contentWidthWithBgImage, height: textRealSize.height+3*contentWidthWithBgImage);
//                
//                
//                
//                
//                
//                _content.setBackgroundImage(UIImage.resizableImage("meme"), for: UIControl.State.normal)
//                
//                
//                
//                
//                
//                print("me icon===\(_icon)")
//                
//                print("me _times=====\(_times)")
//                
//                print("me content====\(_content)")
//                
//                print("me bgimage==\(bgImage)");
//                
//                
//                
//                height = _content.frame;
//                
//                
//            }
//                
//                
//                
//                //别人发的信息
//                
//                
//                
//            else{
//                
//                //显示时间
//                
//                if(chatMessageModel?.hideTime==1){
//                    
//                    _times.frame = CGRect(x: (WIDTH-150)/2, y: 0, width: 150, height: timeWidth)
//                    
//                }
//                
//                
//                
//                _icon.frame = CGRect(x: 10*TMP, y: CGRectGetMaxY(_times.frame)+3*HeightTMP, width: iconWidth, height: iconWidth)
//                
//                
//                
//                //文本信息的最大宽度
//                
//                var MAXWIDTH:CGFloat = WIDTH-40*TMP*2-20*TMP*2;
//                
//                
//                
//                // 文本信息的最大尺寸
//                
//                var textMaxSize = CGSize(width: MAXWIDTH, height: MAXFLOAT)
//                
//                
//                
//                var text:NSString = NSString(string: chatMessageModel!.content!);
//                
//                var dict:NSDictionary = NSDictionary(object:JLTextFont, forKey: NSAttributedString.Key.font as NSCopying)
//                
//                
//                
//                //文本信息真实尺寸
//                
//                var textRealSize = text.boundingRect(with: textMaxSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict as [NSObject : AnyObject] as [NSObject : AnyObject] as! [NSAttributedString.Key : Any], context: nil);
//                
//                
//                
//                _content.frame = CGRect(x: 15*TMP+iconWidth, y: CGRectGetMaxY(_icon.frame)-iconWidth, width: textRealSize.width+4*contentWidthWithBgImage, height: textRealSize.height+2*contentWidthWithBgImage);
//                
//                _content.setBackgroundImage(UIImage.resizableImage("other"), for: UIControl.State.normal)
//                //        bgImage.frame = CGRect(x: 10*TMP+iconWidth, y: _content.frame.origin.y-10*TMP, width: _content.frame.size.width+30*TMP, height: _content.frame.size.height+20*TMP);
//                
//                
//                
//                print("you  icon===\(_icon)")
//                
//                print("you  _times=====\(_times)")
//                
//                print("you  content====\(_content)")
//                
//                print("you  bgimage==\(bgImage)");
//                
//                height = _content.frame.maxY
//            }
//            
//            
//            
//        }
//        
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
