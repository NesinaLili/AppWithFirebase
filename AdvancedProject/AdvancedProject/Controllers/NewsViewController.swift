//
//  NewsViewController.swift
//  AdvancedProject
//
//  Created by Лилия on 8/11/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import ObjectMapper

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var newsModel: [NewsModelArticle] = []
    var imageNews: UIImage?
    var pictureUrl : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsRequest()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        tableView.reloadData()

    }
    
    func newsRequest() {
        
        var parametrs : [String : Any] = [:]
        parametrs["q"] = "Apple"
        parametrs["apiKey"] = "4ea21ee288f24ae880ef13ebda15edbd"
        parametrs["from"] = "2019-07-25"
        parametrs["to"] = "2019-08-02"
        parametrs["pageSize"] = 10
        parametrs["page"] = 2
        
        Alamofire.request("https://newsapi.org/v2/everything", method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            let news = Mapper<NewsModel>().map(JSONObject: response.result.value)
            
            if let articles = news?.articles {
                debugPrint(articles)
                self.newsModel = articles
                self.tableView.reloadData()
            }
        }
    }
    
    func downloadImage(pictureUrl: String) {
        
            let imageUrl = URL(string: pictureUrl)
            URLSession.shared.dataTask(with: imageUrl!, completionHandler: { (data, _, _) in
                DispatchQueue.main.async {
                    self.imageNews = UIImage(data:data!)
                    //self.imageNews.append(UIImage(data:data!)!)
                    self.tableView.reloadData()
                    
                }
            }).resume()
        
        
        
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
       
        cell.titleNewsLabel.text = newsModel[indexPath.row].title
        cell.descriptionNewsLabel.text = newsModel[indexPath.row].autor
        if let url = URL(string: newsModel[indexPath.row].urlToImage!) {
            cell.imageWebView.load(URLRequest(url: url))
        }
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.clipsToBounds = true
        cell.contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.contentView.layer.shadowOpacity = 0.6
        cell.contentView.layer.shadowRadius = 1
        cell.contentView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailNewsViewController") as! DetailNewsViewController
        navigationController?.pushViewController(vc, animated: true)
        vc.nameNews = newsModel[indexPath.row].title ?? ""
        vc.descriptionNews = newsModel[indexPath.row].description ?? ""
        vc.imageUrl = newsModel[indexPath.row].urlToImage ?? ""
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
