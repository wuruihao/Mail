//
//  DepartmentController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/13.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class DepartmentController: UIViewController ,UITableViewDataSource,UITableViewDelegate{

    var sectionData : NSMutableArray!
    var rowData : NSMutableArray!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //模拟数据
        demo()
        //创建一个重用的单元格
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "cellId")
        tableView.separatorStyle = .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func demo(){
        
        let or  = Organization()
        or.demo()
        sectionData = or.departments
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return sectionData.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let department = sectionData[section] as! Department
        rowData = department.members
        return rowData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId") as! ContactsCell
        let department = sectionData[indexPath.section] as! Department
        let data = department.members?[indexPath.row] as! MemberData
        cell.sanpImage.image = UIImage(named: data.memberSanp!)
        cell.name.text = data.memberName
        cell.subTitle.text = data.memberLevel
        return cell

    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kScreenHeight*0.1
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let staffInformationVC = StaffInformationController()
        staffInformationVC.type = "添加"
        staffInformationVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(staffInformationVC, animated: true)
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kScreenHeight*0.05
    }
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(tableView:UITableView, titleForHeaderInSection
        section:Int)->String?{
        
        return "iOS"
    }
    //设置分组尾部高度（不需要尾部，设0.0好像无效）
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let view = UIView(frame: CGRectMake(0,0,kScreenWidth,kScreenHeight*0.05))
        view.backgroundColor = RGBA(242.0, g: 242.0, b: 242.0, a: 1.0)
        let label = UILabel(frame: CGRectMake(kScreenWidth*0.05,0, view.width*0.2,kScreenHeight*0.05))
        label.textColor = RGBA(111.0, g: 116.0, b: 118.0, a: 1.0)
        label.text = self .tableView(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        return view
    }    /*
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
