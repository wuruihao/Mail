//
//  YMNetworkTool.swift
//  TodayNews
//
//  Created by 杨蒙 on 16/7/30.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit
import Alamofire
import MJRefresh
import MBProgressHUD


class ETError: NSObject {
    
    var code:    String?
    var error:   String?
    var message: String?
    
    init(dict: [String: AnyObject]) {
        super.init()
        code = dict["code"] as? String
        error = dict["error"] as? String
        message = dict["message"] as? String
    }
    
}

class NetworkTool: NSObject {
    /// 单例
    static let shareNetworkTool = NetworkTool()
    
    
    func isRequestSuccess(result: NSDictionary) -> Bool {
        
        let string = result.objectForKey("status") as! String
        let status = "ok"
        if string == status {
            return true
        }
        return false
    }
    //登陆请求
    func loginRequest(phone: String, password: String, finishedSel:(data: MemberData)->(),failedSel:(error: ETError)->()){
        
        let url = BASE_URL+"/login"
        let params = ["mobile": phone,
                      "password": password]
        print("url: \(url)")
        print("params: \(params)")
        Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                print("加载失败...")
                return
            }
            let result = response.result.value as? NSDictionary
            print("result: \(result)")
            if self.isRequestSuccess(result!){
                
                if let value = response.result.value {
                    let json = JSON(value)
                    if let data = json["data"].dictionaryObject {
                        let member = MemberData(dict: data)
                        finishedSel(data: member)
                        
                    }else{
                        let json = JSON(value)
                        if let data = json["data"].dictionaryObject {
                            let error = ETError(dict: data)
                            failedSel(error: error)
                        }
                    }
                }
                
            }
        }
    }
}
/*
 //注册请求
 func registerRequest(phone: String, password: String, finishedSel:(data: MemberData)->(),failedSel:(error: ETError)->()){
 
 let url = BASE_URL+"/a3/login/index"
 let params = ["mobile": phone,
 "password": password]
 print("url: \(url)")
 print("params: \(params)")
 Alamofire.request(.GET, url, parameters: params).responseJSON { (response) in
 guard response.result.isSuccess else {
 print("加载失败...")
 return
 }
 let result = response.result.value as? NSDictionary
 print("result: \(result)")
 if self.isRequestSuccess(result!){
 //json 转化成字典 并进行数据解析
 let data = result?.objectForKey("data")
 // 字典转模型(MJExtension)
 let loginData = MemberData.mj_objectWithKeyValues(data)
 finishedSel(data: loginData)
 }else{
 let errorDic = result?.objectForKey("error")
 let error = ETError.mj_objectWithKeyValues(errorDic) as ETError
 failedSel(error: error)
 }
 }
 }
 
 //组织架构
 func departmentRequest(finishedSel:(data:[DepartmentData])->(),failedSel:(error:ETError)->()){
 
 let url = BASE_URL+"/user/list"
 print("url: \(url)")
 Alamofire.request(.GET, url).responseJSON { (response) in
 guard response.result.isSuccess else {
 print("加载失败...")
 return
 }
 let result = response.result.value as? NSDictionary
 print("result: \(result)")
 if self.isRequestSuccess(result!){
 //json 转化成字典 并进行数据解析
 let data = result?.objectForKey("data")
 
 // 字典转模型(MJExtension)
 let dataArray = DepartmentData.mj_objectArrayWithKeyValuesArray(data).mutableCopy() as! [DepartmentData]
 
 for departmentData:DepartmentData in dataArray {
 
 print("members\(departmentData.members)")
 }
 
 finishedSel(data: dataArray)
 }else{
 let errorDic = result?.objectForKey("error")
 let error = ETError.mj_objectWithKeyValues(errorDic) as ETError
 failedSel(error: error)
 }
 }
 }
 */
/*
 
 /// ------------------------ 首 页 -------------------------
 //
 /// 获取首页顶部标题内容(和视频内容使用一个接口)
 func loadHomeTitlesData(finished:(topTitles: [YMHomeTopTitle])->()) {
 let url = BASE_URL + "article/category/get_subscribed/v1/?"
 let params = ["device_id": device_id,
 "aid": 13,
 "iid": IID]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let dataDict = json["data"].dictionary
 if let data = dataDict!["data"]!.arrayObject {
 var topics = [YMHomeTopTitle]()
 for dict in data {
 let title = YMHomeTopTitle(dict: dict as! [String: AnyObject])
 topics.append(title)
 }
 finished(topTitles: topics)
 }
 }
 }
 }
 
 /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
 func loadHomeCategoryNewsFeed(category: String, tableView: UITableView, finished:(nowTime: NSTimeInterval,newsTopics: [YMNewsTopic])->()) {
 let url = BASE_URL + "api/news/feed/v39/?"
 let params = ["device_id": device_id,
 "category": category,
 "iid": IID]
 tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
 let nowTime = NSDate().timeIntervalSince1970
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_header.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let datas = json["data"].array
 var topics = [YMNewsTopic]()
 for data in datas! {
 let content = data["content"].stringValue
 let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
 do {
 let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
 print(dict)
 let topic = YMNewsTopic(dict: dict as! [String : AnyObject])
 topics.append(topic)
 } catch {
 SVProgressHUD.showErrorWithStatus("获取数据失败!")
 }
 
 }
 finished(nowTime: nowTime, newsTopics: topics)
 }
 }
 })
 tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透
 tableView.mj_header.beginRefreshing()
 }
 
 /// 获取首页不同分类的新闻内容
 func loadHomeCategoryMoreNewsFeed(category: String, lastRefreshTime: NSTimeInterval, tableView: UITableView, finished:(moreTopics: [YMNewsTopic])->()) {
 let url = BASE_URL + "api/news/feed/v39/?"
 let params = ["device_id": device_id,
 "category": category,
 "iid": IID,
 "last_refresh_sub_entrance_interval": lastRefreshTime]
 tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_footer.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let datas = json["data"].array
 var topics = [YMNewsTopic]()
 for data in datas! {
 let content = data["content"].stringValue
 let contentData: NSData = content.dataUsingEncoding(NSUTF8StringEncoding)!
 do {
 let dict = try NSJSONSerialization.JSONObjectWithData(contentData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
 let topic = YMNewsTopic(dict: dict as! [String : AnyObject])
 topics.append(topic)
 } catch {
 SVProgressHUD.showErrorWithStatus("获取数据失败!")
 }
 }
 finished(moreTopics: topics)
 }
 }
 })
 }
 
 /// 首页 -> 『+』点击，添加标题，获取推荐标题内容
 func loadRecommendTopic(finished:(recommendTopics: [YMHomeTopTitle]) -> ()) {
 let url = "https://lf.snssdk.com/article/category/get_extra/v1/?"
 let params = ["device_id": device_id,
 "aid": 13,
 "iid": IID]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].arrayObject {
 var topics = [YMHomeTopTitle]()
 for dict in data {
 let title = YMHomeTopTitle(dict: dict as! [String: AnyObject])
 topics.append(title)
 }
 finished(recommendTopics: topics)
 }
 }
 }
 }
 
 /// -------------------------- 视 频 --------------------------
 //
 /// 获取视频顶部标题内容
 func loadVideoTitlesData(finished:(topTitles: [YMVideoTopTitle])->()) {
 // version_code 表示今日头条的版本号，经过测试 >= 5.6 版本新增了『火山直播』
 // os_version 表示 iOS 的系统版本，经测试 >= 8.0 版本新增了『火山直播』
 let url = BASE_URL + "video_api/get_category/v1/?"
 let params = ["device_id": device_id,
 "version_code": "5.7.1",
 "iid": IID,
 "device_platform": "iphone",
 "os_version": "9.3.2"]
 Alamofire
 .request(.GET, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].arrayObject {
 var titles = [YMVideoTopTitle]()
 for dict in data {
 let title = YMVideoTopTitle(dict: dict as! [String: AnyObject])
 titles.append(title)
 }
 finished(topTitles: titles)
 }
 }
 }
 }
 
 /// 获取发布用户的信息
 func loadVideoMediaEntry(entry_id: Int, finished:(mediaEntry: YMMediaEntry) -> ()) {
 let url = BASE_URL + "entry/profile/v1/?"
 let params = ["entry_id": entry_id]
 Alamofire
 .request(.GET, url, parameters: params)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let data = json["data"].dictionaryObject {
 let media = YMMediaEntry(dict: data)
 finished(mediaEntry: media)
 }
 }
 }
 }
 
 /// -------------------------- 关 心 --------------------------
 //
 /// 获取新的 关心数据列表
 func loadNewConcernList(tableView: UITableView, finished:(topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": 0,
 "type": "manage"]
 tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_header.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 })
 tableView.mj_header.automaticallyChangeAlpha = true //根据拖拽比例自动切换透明度
 tableView.mj_header.beginRefreshing()
 }
 
 /// 获取新的 关心数据列表，不显示上拉刷新
 func loadNewConcernListHiddenPullRefresh(finished:(topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": 0,
 "type": "manage"]
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 }
 
 /// 获取更多 关心数据列表
 func loadMoreConcernList(tableView: UITableView, outOffset: Int, finished:(inOffset: Int, topConcerns: [YMConcern], bottomConcerns: [YMConcern]) -> ()) {
 let url = BASE_URL + "concern/v1/concern/list/"
 let params = ["iid": IID,
 "count": 20,
 "offset": outOffset,
 "type": "recommend"]
 tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 tableView.mj_footer.endRefreshing()
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 let inOffset = json["offset"].int!
 if let concern_list = json["concern_list"].arrayObject {
 var topConcerns = [YMConcern]()
 var bottomConcerns = [YMConcern]()
 for dict in concern_list {
 let concern = YMConcern(dict: dict as! [String: AnyObject])
 (concern.concern_time != 0) ? topConcerns.append(concern) : bottomConcerns.append(concern)
 }
 finished(inOffset: inOffset, topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 }
 }
 }
 })
 }
 
 /// 关心界面 -> 底部 cell 的『关心』按钮 点击
 func bottomCellDidClickedCareButton(concernID: String, tableView: UITableView, finish:(topConcerns: [YMConcern], bottomConcerns: [YMConcern])->()) {
 let url = BASE_URL + "concern/v1/commit/care/"
 let params = ["iid": IID, "concern_id": concernID]
 Alamofire
 .request(.POST, url, parameters: params as? [String : AnyObject])
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 YMNetworkTool.shareNetworkTool.loadNewConcernListHiddenPullRefresh({ (topConcerns, bottomConcerns) in
 finish(topConcerns: topConcerns, bottomConcerns: bottomConcerns)
 })
 }
 
 }
 
 /// 关心界面 -> 搜索关心类别和内容
 func loadSearchResult(keyword: String, finished:(keywords: [YMKeyword]) -> ()) {
 let url = BASE_URL + "2/article/search_sug/?keyword=\(keyword)"
 Alamofire
 .request(.GET, url)
 .responseJSON { (response) in
 guard response.result.isSuccess else {
 SVProgressHUD.showErrorWithStatus("加载失败...")
 return
 }
 if let value = response.result.value {
 let json = JSON(value)
 if let datas = json["data"].arrayObject {
 var keywords = [YMKeyword]()
 for data in datas {
 let keyword = YMKeyword(dict: data  as! [String: AnyObject])
 keywords.append(keyword)
 }
 finished(keywords: keywords)
 }
 }
 }
 }
 */
