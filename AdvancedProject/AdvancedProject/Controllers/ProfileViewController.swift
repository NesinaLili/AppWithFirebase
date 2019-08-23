//
//  ProfileViewController.swift
//  AdvancedProject
//
//  Created by Лилия on 8/11/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var surnameUserLabel: UILabel!
    @IBOutlet weak var ageUserLabel: UILabel!
    @IBOutlet weak var dayOfBirthdayUserLabel: UILabel!
    @IBOutlet weak var countryUserLabel: UILabel!
    @IBOutlet weak var regionUserLabel: UILabel!
    @IBOutlet weak var cityUserLabel: UILabel!
    
    var arrayInfoUserProfile = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        
        updateInfo()
    }
    
    func updateInfo() {
        
        nameUserLabel.text = arrayInfoUserProfile.name
        surnameUserLabel.text = arrayInfoUserProfile.surName
        ageUserLabel.text = "\(arrayInfoUserProfile.age)"
        dayOfBirthdayUserLabel.text = arrayInfoUserProfile.dayOfBirthday
        countryUserLabel.text = arrayInfoUserProfile.country
        regionUserLabel.text = arrayInfoUserProfile.region
        cityUserLabel.text = arrayInfoUserProfile.city
    }
    @IBAction func didTapLogOut(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}
