//
//  ContactsController.swift
//  EnjoytouchMail
//
//  Created by Enjoytouch on 16/9/5.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit
import CoreFoundation
class ContactsController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var shouldShowSearchResults = false
    
    var dataSoure : NSMutableArray!
    var searchData :NSArray!
    var sectionTitlesArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //模拟数据
        demo()
        
        //创建一个重用的单元格
        let nib = UINib(nibName: "ContactsCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "contactsCell")
        
        configureSearchController()
    }
    
    @IBAction func addContacts(sender: UIButton) {
        
        let addContactsVC = AddContactsController()
        addContactsVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addContactsVC, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureSearchController() {
        
        // 初始化搜索控制器，并且进行最小化的配置
        searchController = UISearchController(searchResultsController: nil)
        //searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // 放置 搜索条在 tableView的头部视图中
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func demo(){
        let me  = MemberData(name: "吴瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let me2  = MemberData(name: "瑞豪", sanp: "Login_male.png", level: "iOS工程师")
        let me3  = MemberData(name: "豪", sanp: "Login_male.png", level: "iOS工程师")
        dataSoure = [me,me2,me3]
        let array = [me,me2,me3]
        searchData = [me,me2,me3]
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchString = searchController.searchBar.text
        // 刷新 tableView
        tableView.reloadData()
        
    }
    /*
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        
        let searchString = searchController.searchBar.text
        /*
        for i in 0 ... searchData.count {
            
            let data = searchData[i] as! MemberData
            let range = data.memberName!.rangeOfString(searchString!)
            
            if range == nil {
                searchData.removeObject(data)
            }
            
        }
 */
        
        for data:MemberData in searchData.mutableCopy() as! [MemberData] {
            
            let range = data.memberName!.rangeOfString(searchString!)
            
            if range == nil {
                searchData.removeObject(data)
            }
        }
        
        // 刷新 tableView
        tableView.reloadData()
    }
    */
    //设置分区数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if shouldShowSearchResults == true {
            
            return 1
        }
        return dataSoure.count;
    }
    
    //返回表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if shouldShowSearchResults == true {
            return searchData.count
        }
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
            
            if shouldShowSearchResults == true {
                
                let data = searchData[indexPath.row] as! MemberData
                cell.sanpImage.image = UIImage(named: data.memberSanp!)
                cell.name.text = data.memberName
                cell.subTitle.text = data.memberLevel
                return cell
            }else{
                
                let userSection = dataSoure.objectAtIndex(indexPath.section)
                let data = userSection[indexPath.row] as! MemberData
                cell.sanpImage.image = UIImage(named: data.memberSanp!)
                cell.name.text = data.memberName
                cell.subTitle.text = data.memberLevel
                return cell
            }
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
        if shouldShowSearchResults == true {
            
            return 0
        }
        return kScreenHeight*0.05
    }
    
    //设置分组尾部高度（不需要尾部，设0.0好像无效）
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if shouldShowSearchResults == true {
            
            return nil
        }
        
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

