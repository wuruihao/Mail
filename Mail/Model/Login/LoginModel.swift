//
//  LoginModel.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/9.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class MemberData: NSObject {
    
    var id:         Int = 0
    var sex:        String?
    var mobile:     String?
    var token:      String?
    var level_name: String?
    var head_img:   String?
    var nickname:   String?
    var department: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        id = dict["id"] as! Int
        sex = dict["sex"] as? String
        mobile = dict["mobile"] as? String
        token = dict["token"] as? String
        level_name = dict["level_name"] as? String
        head_img = dict["head_img"] as? String
        nickname = dict["nickname"] as? String
        department = dict["department"] as? String
    }
    
}
