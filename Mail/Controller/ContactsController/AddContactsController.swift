//
//  AddContactsController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class AddContactsController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var departmentTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var workmMailbox: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func sureSubmitServer(sender: UIButton) {
        
        let alertView = UIAlertView()
        
        if nameTextField.text == "" {
            alertView.title = "请输入姓名"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            nameTextField.becomeFirstResponder()
            return
        }
        if departmentTextField.text == "" {
            alertView.title = "请输入公司"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            departmentTextField.becomeFirstResponder()
            return
        }
        if positionTextField.text == "" {
            alertView.title = "请输入职位"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            positionTextField.becomeFirstResponder()
            return
        }
        if phoneTextField.text == "" {
            alertView.title = "请输入手机号码"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
             phoneTextField.becomeFirstResponder()
            return
        }
        if workmMailbox.text == "" {
            alertView.title = "请输入工作邮箱"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            workmMailbox.becomeFirstResponder()
            return
        }
        if companyTextField.text == "" {
            alertView.title = "请输入公司"
            alertView.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            }
            companyTextField.becomeFirstResponder()
            return
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
