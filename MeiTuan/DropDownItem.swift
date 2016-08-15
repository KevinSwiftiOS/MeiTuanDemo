//
//  DropDownItem.swift
//  MeiTuan
//
//  Created by hznucai on 16/7/11.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit

class DropDownItem: UIControl {

  //1 label 懒加载
    lazy var titleLabel:UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.orangeColor()
        return label
    }()
    
    
//2 imageView
    lazy var imageView:UIImageView = {
        var image = UIImageView()
        return image
    }()
//init初始化
    init(frame: CGRect,title:String,image:UIImage) {
        super.init(frame: frame)
        self.frame = frame
        self.addSubview(titleLabel)
        self.addSubview(imageView)
        titleLabel.text = title
        imageView.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var size = CGSize()
    //更改布局
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = self.imageView.image?.size
        //获取文字长度
        let titleSize = NSString(string: self.titleLabel.text!).sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(13)])
        //title的最大宽度
        let titleMaxWidth:CGFloat = self.frame.size.width - (imageSize?.width)! - 25
        var titleWidth:CGFloat = titleSize.width
        //title太大了
        if(titleWidth > titleMaxWidth){
            titleWidth = titleMaxWidth
        }
        var sizeHeight:CGFloat = 0
        var sizeWidth:CGFloat = 0
        //控件的总高度
        if(titleSize.height > imageSize?.height){
            sizeHeight = titleSize.height
        }else{
            sizeHeight = (imageSize?.height)!
        }
        //控件的总宽度
        sizeWidth = titleWidth + (imageSize?.width)!
        size = CGSizeMake(sizeWidth, sizeHeight)
        let offsetX:CGFloat = (self.frame.width - sizeWidth)
        let offsetY:CGFloat = (self.frame.height - sizeHeight)
        //计算位置
        titleLabel.frame = CGRectMake(offsetX, offsetY, titleWidth, titleSize.height)
        imageView.frame = CGRectMake(offsetX + titleWidth + 5, offsetY + (sizeHeight - (imageSize?.height)!) / 2, (imageSize?.width)!, (imageSize?.height)!)
        
    }
  
}
