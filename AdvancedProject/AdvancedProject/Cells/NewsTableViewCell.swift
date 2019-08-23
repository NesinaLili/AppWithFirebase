//
//  NewsTableViewCell.swift
//  AdvancedProject
//
//  Created by Лилия on 8/12/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import WebKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var descriptionNewsLabel: UILabel!
    @IBOutlet weak var conrentView: UIView!
    
    @IBOutlet weak var imageWebView: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
