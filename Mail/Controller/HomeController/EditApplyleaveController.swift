//
//  EditApplyleaveController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/12.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
extension NSDate{
    class func sinaDate(string: String) -> NSDate?{
        //转换日期
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //转换
        return df.dateFromString(string)
    }
    //根据判断  获取不同时间段的称呼
    var dateDesctiption: String {
        //1、使用日历类取出当前的日期
        let calendar = NSCalendar.currentCalendar()
        //判断
        if calendar.isDateInToday(self){
            //把获取的日期和现在的系统时进行比较，判断时间差
            let dateTime = Int(NSDate().timeIntervalSinceDate(self))
            if dateTime < 60 {
                return "��刚刚"
            }
            if dateTime < 3600 {
                return "��/(dateTime / 60)分钟前"
            }
            return "��/(dateTime / 3600)小时前"
        }
        //日格式字符串
        var fmtString = "HH:mm"
        if calendar.isDateInYesterday(self){
            fmtString = "昨天" + fmtString
        }else{
            fmtString = "MM-dd" + fmtString
            let coms = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            if coms.year > 0{
                fmtString = "yyyy-" + fmtString
            }
        }
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = fmtString
        return df.stringFromDate(self)
    }
}

class EditApplyleaveController: UIViewController {
    
    @IBOutlet weak var endDay: UILabel!
    @IBOutlet weak var beginDay: UILabel!
    @IBOutlet weak var leaveDay: UILabel!
    @IBOutlet weak var leaveType: UILabel!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var backView: UIView!
    var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func addDatePicker(tag:NSInteger){
        
        backView = UIView(frame: self.view.frame)
        backView.backgroundColor = RGBA(0.0, g: 0.0, b: 0.0, a: 0.5)
        UIApplication.sharedApplication().delegate?.window!!.addSubview(backView)
        
        //注册tap手势事件
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(EditApplyleaveController.handleTap(_:)))
        backView.addGestureRecognizer(tapRecognizer)
        
        //创建日期选择器
        datePicker = UIDatePicker(frame: CGRectMake(0, kScreenHeight, kScreenWidth,kScreenHeight*0.3))
        datePicker.tag = tag
        datePicker.backgroundColor = UIColor.whiteColor()
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(EditApplyleaveController.dateChanged(_:)),forControlEvents: UIControlEvents.ValueChanged)
        
        UIApplication.sharedApplication().delegate?.window!!.addSubview(datePicker)
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = NSDateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print(formatter.stringFromDate(datePicker.date))
        print("datePicker.date\(datePicker.date)")
        if datePicker.tag == 1 {
            
            beginDay.text = formatter.stringFromDate(datePicker.date)
            
        }else if datePicker.tag == 2 {
            endDay.text = formatter.stringFromDate(datePicker.date)
        }
    }
    
    func handleTap(sender:UITapGestureRecognizer){
        
        UIView.animateWithDuration(0.4, animations: {
            self.datePicker.y = kScreenHeight
        }) { (finished:Bool) in
            
            self.datePicker.removeFromSuperview()
            self.backView.removeFromSuperview()
        }
    }
    
    @IBAction func selectedLeaveType(sender: UITapGestureRecognizer) {
        
        
    }
    @IBAction func backAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func nextAction(sender: UIButton) {
        
        
        
    }
    @IBAction func beginTime(sender: UIButton) {
        
        addDatePicker(1)
        UIView.animateWithDuration(0.4) {
            self.datePicker.y = kScreenHeight*0.7
        }
    }
    @IBAction func endTime(sender: UIButton) {
        
        addDatePicker(2)
        UIView.animateWithDuration(0.4) {
            self.datePicker.y = kScreenHeight*0.7
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
