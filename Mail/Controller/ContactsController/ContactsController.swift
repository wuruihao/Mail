//
//  ContactsController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/5.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import CoreFoundation
class ContactsController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSoure : NSMutableArray!
    var sectionTitlesArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //模拟数据
        demo()
        
        //创建一个重用的单元格
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "contactsCell")
        
    }
    
    @IBAction func addContacts(sender: UIButton) {
        
        let addContactsVC = AddContactsController()
        addContactsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addContactsVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func demo(){
        let me  = MemberData(name: "吴瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let me2  = MemberData(name: "瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let me3  = MemberData(name: "豪", sanp: "Login_male.png", level: "iOS工程师")
        dataSoure = [me,me2,me3]
        let array = [me,me2,me3]
        sectionTitlesArray = NSMutableArray()
        sortDataArray(array)
    }
    
    //实现索引数据源代理方法
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
      return sectionTitlesArray.mutableCopy() as? [String]
    }
    
    //点击索引，移动TableView的组位置
     func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String,
     atIndex index: Int) -> Int {
     var tpIndex:Int = 0
     //遍历索引值
     for character in sectionTitlesArray{
     //判断索引值和组名称相等，返回组坐标
     if character as! String == title{
     return tpIndex
     }
     tpIndex += 1
     }
     return 0
     }
    
    //设置分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSoure.count;
    }
    
    //返回表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSoure.objectAtIndex(section).count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kScreenHeight*0.1;
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell{
            
            //为了提供表格显示性能，已创建完成的单元需重复使用
            let identify:String = "contactsCell"
            //同一形式的单元格重复使用，在声明时已注册
            let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath)
                as! ContactsCell
            
            let userSection = dataSoure.objectAtIndex(indexPath.section)
            let data = userSection[indexPath.row] as! MemberData
            cell.sanpImage.image = UIImage(named: data.memberSanp!)
            cell.name.text = data.memberName
            cell.subTitle.text = data.memberLevel
            return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        let staffInformationVC = StaffInformationController()
        staffInformationVC.type = "编辑"
        staffInformationVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(staffInformationVC, animated: true)
    }
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(tableView:UITableView, titleForHeaderInSection
        section:Int)->String?{
        
        return self.sectionTitlesArray[section] as? String
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kScreenHeight*0.05
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
    }
    
    /*
     func sortDataArray(list:[MemberData]){
     
     let indexCollation = UILocalizedIndexedCollation.currentCollation()
     
     sectionTitles.addObjectsFromArray(indexCollation.sectionTitles)
     
     let highSection = sectionTitles.count
     let sortedArray = NSMutableArray(capacity: highSection)
     
     for var i = 0; i < highSection; i = i+1 {
     let sectionArray = NSMutableArray(capacity: 1)
     sortedArray .addObject(sectionArray)
     }
     
     
     for data:MemberData in list {
     
     let ease = EaseChineseToPinyin()
     let firstLetter = ease.pinyinFromChineseString(data.memberName)
     let index = firstLetter.endIndex.advancedBy(1)
     let string = firstLetter.substringToIndex(index)
     let section = indexCollation.sectionForObject(string, collationStringSelector: #selector("uppercaseString"))
     
     let array = sortedArray.objectAtIndex(section)
     array.addObject(data)
     }
     }
     */
    
    func sortDataArray(dataArray:[MemberData]){
    
        dataSoure.removeAllObjects()
        sectionTitlesArray.removeAllObjects()
        
        let indexCollation = UILocalizedIndexedCollation.currentCollation()
        
        let sectionTitles = NSMutableArray.init(array: indexCollation.sectionTitles)
        
        let highSection = sectionTitles.count
        
        let sortedArray = NSMutableArray.init(capacity: highSection)
        
        for _ in 0...highSection {
            
            let sectionArray = NSMutableArray.init(capacity: 1)
            
            sortedArray.addObject(sectionArray)
            
        }
        
        for data:MemberData in dataArray {
            let ease = EaseChineseToPinyin()
            let firstLetter = ease.pinyinFromChineseString(data.memberName)
            let sectionH = indexCollation.sectionForObject((firstLetter as NSString).substringToIndex(1), collationStringSelector: #selector(self.uppercaseString) )
            
            let array = sortedArray.objectAtIndex(sectionH)
            
            array.addObject(data)
            
        }
        
        //每个section内的数组排序
        for temp in 0...sortedArray.count - 1 {
            
            let array = sortedArray.objectAtIndex(temp).sortedArrayUsingComparator({ (obj1, obj2) -> NSComparisonResult in
                
                let firstLetter1:NSString = self.getTheFirstLetterStrings(obj1 as! String)
                
                let firstLetter2:NSString = self.getTheFirstLetterStrings(obj2 as! String)
                
                return firstLetter1.caseInsensitiveCompare(firstLetter2 as String)
                
            })
            
            sortedArray.replaceObjectAtIndex(temp, withObject: NSMutableArray.init(array: array))
            
        }
        
        for temp in 0...sectionTitles.count {
            
            if sortedArray.objectAtIndex(temp).count > 0 {
                
                let sectionT = sectionTitles.objectAtIndex(temp)
                
                sectionTitlesArray.addObject(sectionT)
                
                dataSoure.addObject(sortedArray.objectAtIndex(temp))
                
            }
            
        }
        
    }
    
    func uppercaseString()->String{return "uppercaseString"}
    
    func getTheFirstLetterStrings(content:String)->String{
        
        if content.characters.count < 1 {
            
            return " "
            
        }else{
            
            let index = (content as NSString).characterAtIndex(0)
            
            if( index > 0x4e00 && index < 0x9fff)
            {
                return self.pinYinZChines(content)
                
            }else{
                
                let index = content.startIndex.advancedBy(0)
                
                let firstString = content[index]
                
                let stringZ = String.init(firstString)
                
                return stringZ.uppercaseString
                
            }
            
        }
        
    }
    
    func pinYinZChines(content:String)->String{
        
        let transformContents = CFStringCreateMutableCopy(nil, 0, content)
        
        CFStringTransform( transformContents, nil, kCFStringTransformMandarinLatin, false)
        
        CFStringTransform( transformContents, nil, kCFStringTransformStripDiacritics, false)
        
        let ztransformContents = transformContents as String
        
        let index = ztransformContents.startIndex.advancedBy(0)
        
        let firstString = ztransformContents[index]
        
        let stringZ = String.init(firstString)
        
        return stringZ.uppercaseString
        
    }
    
}

