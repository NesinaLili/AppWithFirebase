//
//  LoginViewController.swift
//  AdvancedProject
//
//  Created by Лилия on 8/8/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emailUserTextField: UITextField!
    @IBOutlet weak var passwordUserTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordText: UIButton!
    
    var isShowPassword: Bool = false
    var arrayInfoUser = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordUserTextField.isSecureTextEntry = true
        navigationController?.navigationBar.isHidden = false
        
        userLogin()
        
        hideKeyboardWhenTappedAround()
        
        emailUserTextField.delegate = self
        passwordUserTextField.delegate = self
        
        designTextField(textField: emailUserTextField)
        designTextField(textField: passwordUserTextField)
        
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 15
        
        
    }
    
    func userLogin() {
        
        if ReachabilityModel.isConnectedToNetwork() {
            let userInfo = UserModel()
            let ref: DatabaseReference!
            ref = Database.database().reference(withPath: "list")
            ref.observe(.value) { snapshot in
                
                if let value = snapshot.value as? [String: Any] {
                    
                    if let age = value["age"] as? Int {
                        userInfo.age = age
                    }
                    if let city = value["city"] as? String {
                        userInfo.city = city
                    }
                    if let country = value["country"] as? String {
                        userInfo.country = country
                    }
                    if let dateOfBirthday = value["dayOfBirthday"] as? String {
                        userInfo.dayOfBirthday = dateOfBirthday
                    }
                    if let email = value["email"] as? String {
                        userInfo.email = email
                    }
                    if let name = value["name"] as? String {
                        userInfo.name = name
                    }
                    if let password = value["password"] as? String {
                        userInfo.password = password
                    }
                    if let phone = value["phone"] as? String {
                        userInfo.phone = phone
                    }
                    if let region = value["region"] as? String {
                        userInfo.region = region
                    }
                    if let surName = value["surName"] as? String {
                        userInfo.surName = surName
                    }
                    if let zip = value["zip"] as? String {
                        userInfo.zip = zip
                    }
                    if let location = value["location"] as? [String: Any?] {
                        let locationUser = UserLocationModel()
                        if let latitude = location["latitude"] as? Double {
                            locationUser.latitude = latitude
                        }
                        if let longtitude = location["longtitude"] as? Double {
                            locationUser.longtitude = longtitude
                        }
                        userInfo.location = locationUser
                    }
                    self.arrayInfoUser = userInfo
                }
            }
        } else {
            alert(title: "Attention", message: "No internet connection")
        }
    }
    
    func alert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func designTextField(textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    
    func errorTextField(textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.red.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    @IBAction func didTapShowPassword(_ sender: Any) {
        isShowPassword = !isShowPassword
        changePasswordShowing(isShowPassword: isShowPassword)
    }
    
    func changePasswordShowing(isShowPassword: Bool) {
        if passwordUserTextField.text != "" {
            if !isShowPassword  {
                passwordUserTextField.isSecureTextEntry = true
                passwordText.setTitle("ПОКАЗАТЬ ПАРОЛЬ", for: .normal)
            } else {
                passwordUserTextField.isSecureTextEntry = false
                passwordText.setTitle("СКРЫТЬ ПАРОЛЬ", for: .normal)
            }
        }
    }
    
    @IBAction func didTapSignIn(_ sender: Any) {
        
        if !emailUserTextField.text!.isEmpty {
            if !passwordUserTextField.text!.isEmpty {
                if emailUserTextField.text == arrayInfoUser.email && passwordUserTextField.text == arrayInfoUser.password {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    vc.locationUserMap = arrayInfoUser.location!
                    vc.arrayInfoUserOnMap = arrayInfoUser
                    navigationController?.pushViewController(vc, animated: true)
                } else if emailUserTextField.text != arrayInfoUser.email {
                    if passwordUserTextField.text != arrayInfoUser.password {
                        errorTextField(textField: emailUserTextField)
                        errorTextField(textField: passwordUserTextField)
                        alert(title: "Ooooops", message: "Wrong email and password")
                    } else {
                        errorTextField(textField: emailUserTextField)
                        alert(title: "Ooooops", message: "Wrong email")
                    }
                    
                } else if passwordUserTextField.text != arrayInfoUser.password {
                    errorTextField(textField: passwordUserTextField)
                    alert(title: "Ooooops", message: "Wrong password")
                }
                
            } else {
                errorTextField(textField: passwordUserTextField)
                alert(title: "Error", message: "Password field is empty")
            }
        } else {
            errorTextField(textField: emailUserTextField)
            alert(title: "Error", message: "Email field is empty")
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y: textField.frame.height - 1), size: CGSize(width: textField.frame.width, height:  1))
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
}


