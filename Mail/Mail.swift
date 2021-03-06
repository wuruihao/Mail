//
//  Mail.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/14.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

let userID = "userID"
let userSex = "userSex"
let userMobile = "userMobile"
let userToken = "userToken"
let userLevel = "userLevel"
let userHeadImg = "userHeadImg"
let userNickname = "userNickname"
let userDepartment = "userDepartment"


let kScreenWidth = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height

func kFitWidth(value : CGFloat) -> CGFloat {
    return (kScreenWidth/750.0*value)
}
func kFitHeight(value : CGFloat) -> CGFloat {
    return kScreenWidth/1334.0*value
}
func kFontSize(value : CGFloat) -> UIFont {
    return UIFont.systemFontOfSize(kScreenHeight/750*value)
}
func FontSize(value : CGFloat) -> CGFloat {
    return (kScreenHeight/750*value)
}
func kBoldFitSize(value : CGFloat) -> UIFont {
    return UIFont.boldSystemFontOfSize(kScreenHeight/750*value)
}
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
