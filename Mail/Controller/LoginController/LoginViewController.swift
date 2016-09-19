//
//  LoginViewController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/7.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userName.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    @IBAction func registerAction(sender: UIButton) {
        
        print("注册事件")
    }
    @IBAction func cancelAction(sender: UIButton) {
        
        UIApplication.sharedApplication().keyWindow?.rootViewController = ETTabBarController()
    }
    @IBAction func login(sender: UIButton) {
        
        let alertView = UIAlertView()
        
        if userName.text == nil {
            alertView.title = "请输入手机号"
            alertView.show()
            
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            userName.becomeFirstResponder()
            return
        }
        if password.text == nil {
            alertView.title = "请输入密码"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            password.becomeFirstResponder()
            return
        }
        
        NetworkTool.shareNetworkTool.loginRequest(userName.text!, password: password.text!, finishedSel: { (data:MemberData) in
            
            print("data:\(data)")
            
            self.saveUserDefaults(data)
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = ETTabBarController()
            
            
        }) { (error:ETError) in
            
            alertView.title = error.message!
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            
            print("error:\(error)")
        }
        
    }
    
    
    func saveUserDefaults(data:MemberData){
        
        var defaults:NSUserDefaults!
        defaults = NSUserDefaults()
        
        defaults.setInteger(data.id as Int, forKey: userID)
        if data.sex != nil {
            defaults.setObject(data.sex! as String, forKey: userSex)
        }
        if data.mobile != nil {
            defaults.setObject(data.mobile! as String, forKey: userMobile)
        }
        if data.token != nil {
            defaults.setObject(data.token! as String, forKey: userToken)
        }
        if data.level_name != nil {
            defaults.setObject(data.level_name! as String, forKey: userLevel)
        }
        if data.head_img != nil {
            defaults.setObject(data.head_img! as String, forKey: userHeadImg)
        }
        if data.nickname != nil {
            defaults.setObject(data.nickname! as String, forKey: userNickname)
        }
        if data.department != nil {
            defaults.setObject(data.department! as String, forKey: userDepartment)
        }
    }
}
