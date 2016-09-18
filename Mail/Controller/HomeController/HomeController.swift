//
//  HomeController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/12.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sanpImage: UIImageView!
    
    var dataSoure : NSMutableArray!
    var collectionView: UICollectionView!
    
    var timer:NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = NSUserDefaults().objectForKey(userNickname) as! String!
        if title != nil {
            titleLabel.text = "您好, \(title)"
        }
        
        //模拟数据
        demoData()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical  //滚动方向
        layout.itemSize = CGSize(width:(kScreenWidth-80)/3, height:(kScreenWidth-80)/3) //设置所有cell的size  太重要了 找了半天。(自学就是辛苦呀！！)
        layout.minimumLineSpacing = 10.0  //上下间隔
        layout.minimumInteritemSpacing = 10.0 //左右间隔
        layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)  //缩进
        
        collectionView = UICollectionView(frame: CGRect(x:0, y:timeLabel.y+timeLabel.height, width:kScreenWidth, height:self.view.frame.size.height-timeLabel.y-timeLabel.height-49), collectionViewLayout: layout)
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(collectionView)
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "homeCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        doTimer()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func doTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(60.0, target: self, selector: #selector(HomeController.timerFireMethod(_:)), userInfo: nil, repeats:true);
        timer.fire()
    }
    func timerFireMethod(timer: NSTimer) {
        let formatter = NSDateFormatter();
        formatter.dateFormat = "yyyy年MM月dd日 EEEE HH:mm"
        let strNow = formatter.stringFromDate(NSDate())
        timeLabel.text  = "\(strNow)"
        print("timeLabel:\(strNow)")
    }
    func demoData(){
        
        let data =  HomeData(name: "公告通知", sanp: "notify.png")
        let data2 =  HomeData(name: "通讯录", sanp: "txl.png")
        let data3 =  HomeData(name: "申请请假", sanp: "txl.png")
        let data4 =  HomeData(name: "个人中心", sanp: "member.png")
        let data5 =  HomeData(name: "备忘录", sanp: "txl.png")
        let data6 =  HomeData(name: "辅助工具", sanp: "notify.png")
        
        dataSoure = NSMutableArray(objects: data,data2,data3,data4,data5,data6)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSoure.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("homeCell", forIndexPath: indexPath) as! HomeCell
        
        let data = dataSoure[indexPath.row] as! HomeData
        
        cell.title.text = data.title
        cell.icon.image = UIImage(named: data.icon!)
        cell.backgroundColor = UIColor.clearColor()
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        
        let alert = UIAlertView()
        
        switch indexPath.row {
        case 0:
            let notifyVC =  NotifyController()
            notifyVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(notifyVC, animated: true)
            
            break
        case 1:
            
            tabBarController?.selectedIndex = 1
            
            break
        case 2:
            let applicationVC = ApplicationController()
            applicationVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(applicationVC, animated: true)
            break
        case 3:
            
            tabBarController?.selectedIndex = 3
            /*
             alert.title = "个人中心"
             alert.show()
             let time: NSTimeInterval = 1.0
             let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
             dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
             alert.dismissWithClickedButtonIndex(0, animated: true)
             }
             */
            break
        case 4:
            alert.title = "备忘录"
            alert.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alert.dismissWithClickedButtonIndex(0, animated: true)
            }
            break
        case 5:
            alert.title = "辅助工具"
            alert.show()
            let time: NSTimeInterval = 1.0
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) { () -> Void in
                alert.dismissWithClickedButtonIndex(0, animated: true)
            }
            break
            
        default:
            break
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
