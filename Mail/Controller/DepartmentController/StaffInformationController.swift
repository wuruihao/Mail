//
//  StaffInformationController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/8.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class StaffInformationController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var workMailbox: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    var type: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if type == "编辑" {
            editBtn.setTitle("编辑联系人信息", forState:.Normal)
        }else {
            editBtn.setTitle("添加到常联系人", forState:.Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backAction(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func editInfoAction(sender: UIButton) {
        
        if type == "编辑" {
            
            self.navigationController?.pushViewController(AddContactsController(), animated: true)
            
        }else {
            
            //网络请求添加到常联系人
            
        }
        
    }
}
