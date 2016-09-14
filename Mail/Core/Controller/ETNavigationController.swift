//
//  ETNavigationController.swift
//  swfit_uikit_demo
//
//  Created by Enjoytouch on 16/7/18.
//  Copyright © 2016年 shuzhenguo. All rights reserved.
//

import UIKit

class ETNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //navi bar 属性设置
//        self.navigationBar.setBackgroundImage(UIImage(named: "white.png")!, forBarPosition: .TopAttached, barMetrics: .Default)
//        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationBar.translucent = false;
        //背景图片
        let shadowImageView = UIImageView(image: UIImage(named: "leftside_shadow_bg"))
        shadowImageView.frame = CGRect(x: -10, y: 0, width: 10, height: self.view.frame.size.height);
        self.view.addSubview(shadowImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
