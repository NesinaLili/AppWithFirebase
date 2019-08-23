//
//  DetailNewsViewController.swift
//  AdvancedProject
//
//  Created by Лилия on 8/12/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import WebKit

class DetailNewsViewController: UIViewController {

    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var imageNewsDetail: UIImageView!
    @IBOutlet weak var nameNewsDetailLabel: UILabel!
    @IBOutlet weak var descriptionNewsDetailTextView: UITextView!
    
    @IBOutlet weak var imageWebView: WKWebView!
    
    var titleNews: String = ""
    var nameNews: String = ""
    var descriptionNews: String = ""
    var imageUrl: String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleNewsLabel.text = titleNews
        nameNewsDetailLabel.text = nameNews
        descriptionNewsDetailTextView.text = descriptionNews
        
        if let url = URL(string: imageUrl) {
            imageWebView.load(URLRequest(url: url))
        }

    }
    @IBAction func didTapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
