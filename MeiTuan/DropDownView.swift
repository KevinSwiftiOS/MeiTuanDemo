//
//  DropDownView.swift
//  MeiTuan
//
//  Created by hznucai on 16/7/11.
//  Copyright © 2016年 hznucai. All rights reserved.
//

import UIKit
let buttonTag:Int = 1000 //方便调用
let buttonHeight:CGFloat = 40// 高度
let seperatorLineWidth:CGFloat = 1 //分割线的宽度
//点击了那个按钮需要一个协议
@objc
public protocol DropDownButtonDelegate:NSObjectProtocol{
    //展开了几个按钮
    func showDropDownMenu(index:Int)
    //收起菜单
    func hideDropDownMenu()
    
}

class DropDownView: UIView {
    var delegate:DropDownButtonDelegate!
    var m_lastTap:Int! //总共有几个菜单 -1为未展开的状态
    var titles = [String]() //text分别为什么名称的字典
    var lastTapObj:String!// 记录收起第几个菜单
     init(frame: CGRect,titles:[String]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellowColor()
        self.titles = titles
        //初始化为-1 创建3个分割线
 self.m_lastTap = -1
        for index in 1 ..< 3{
            let width = CGRectGetWidth(self.frame) / 3
            let Bframe:CGRect = CGRectMake(CGFloat(index) * width, 0, seperatorLineWidth, buttonHeight)
            let speratorLone:UIView = UIView(frame: Bframe)
            speratorLone.backgroundColor = UIColor(red: 235.0 / 255, green: 235.0 / 255, blue: 235.0 / 255, alpha: 1.0)
            self.addSubview(speratorLone)
            
        }
        //for循环添加图片
        for index in 1 ..< 3{
            let width = CGRectGetWidth(self.frame)
            let Bframe:CGRect = CGRectMake(CGFloat(index) * width, 0, seperatorLineWidth, buttonHeight)

            let image = UIImage(named: "mark1")
            let button = DropDownItem(frame: Bframe,title: titles[index],image: image!)
            button.tag = buttonTag + index
            //设置点击的事件
            button.addTarget(self, action: #selector(DropDownView.onShowMenuAction(_:)), forControlEvents: .TouchUpInside)
            self.addSubview(button)
        }
        let underThe:UIView = UIView(frame: CGRectMake(0,buttonHeight,UIScreen.mainScreen().bounds.size.width,1))
        underThe.backgroundColor = UIColor(red: 1.0 / 255, green: 1.0 / 255, blue: 1.0 / 255, alpha: 1.0)
        self.addSubview(underThe)
        //上面的分割线
        let on:UIView = UIView(frame: CGRectMake(0,0,underThe.frame.size.width,1))
        on.backgroundColor = UIColor(red: 1.0 / 255, green: 1.0 / 255, blue: 1.0 / 255, alpha: 1.0)
        self.addSubview(on)
        //监听是否影藏了菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(DropDownView.hideMenu(_:)), name: "hideMenu", object: lastTapObj)
        
    }
    //处理点击按钮的逻辑
    func onShowMenuAction(sender:UIControl){
        let index = sender.tag
        if(m_lastTap != index){
            //展开的菜单确保只有一个
            if m_lastTap >= 0{
                self.changeButtonTaf(m_lastTap, Rotation: 0)
            }
            //当前展开了几个菜单
            m_lastTap = index
            //改变菜单的样式
            self.changeButtonTaf(index, Rotation: CGFloat(M_PI))
            //通知代理
            self.delegate.showDropDownMenu(index - buttonTag)
        }else{
            //改变收起菜单
            self.changeButtonTaf(m_lastTap, Rotation: 0)
            //恢复到未选状态
            m_lastTap = -1
            self.delegate.hideDropDownMenu()
            
        }
    }
    func hideMenu(noti:NSNotification){
        //拿到收起第几个菜单
        lastTapObj = noti.object as! String
        //改变菜单按钮的样式
        self.changeButtonTaf(Int(lastTapObj)! + buttonTag, Rotation: 0)
        //恢复到未选择的状态
        m_lastTap = -1
    }
    func changeButtonTaf(idnex:Int,Rotation angle:CGFloat){
        UIView.animateWithDuration(1) { 
            let item = self.viewWithTag(idnex) as! DropDownItem
            item.imageView.transform = CGAffineTransformMakeRotation(angle)
            if angle == 0{
                item.titleLabel.textColor = UIColor(red: 68.0 / 255, green: 68.0 / 255, blue: 68.0 / 255, alpha: 1.0)
                item.imageView.image = UIImage(named: "mark1")
            }else{
                item.titleLabel.textColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
                item.imageView.image = UIImage(named: "mark1")

            }
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
