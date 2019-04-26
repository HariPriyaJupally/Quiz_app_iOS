//
//  SignUpViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/8/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    
    var backendless = Backendless.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpeg")!)
        // Do any additional setup after loading the view.
       
        let backgroundImage = UIImage(named: "greylights.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    // checks if the passsord count is greater than or equal to 8
    func isValidPassword(password:String) -> Bool{
        return password.count >= 8
    }
    
    //This function is used to display alert message.
    
    func displayAlert(msg: String){
        let  alert  =  UIAlertController(title:  "Alert",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  nil))
        self.present(alert,  animated:  true,  completion:  nil)
    }
    
    //This function is used to display a message after the registration user is completed.
    
    func displayAfterRegistered(msg: String) {
        let  alert  =  UIAlertController(title:  "Registration Complete!",  message: msg,  preferredStyle:  .alert)
        alert.addAction(UIAlertAction(title:  "OK",  style:  .default,  handler:  { _ in
            self.performSegue(withIdentifier: "newuser", sender: nil)
        }))
        self.present(alert,  animated:  true,  completion:  nil)
    }
    
    //This function is used register to register a new user after the user clicks on the register button and displays appropriate message according to the users action.
    
    @IBAction func registerBTN(_ sender: Any) {
        print("in")
        if fullNameTF.text!.isEmpty || emailIdTF.text!.isEmpty || passwordTF.text!.isEmpty || confirmPasswordTF.text!.isEmpty || mobileNumberTF.text!.isEmpty {
            displayAlert(msg: "Enter values for all the fields")
        } else if(!isValidPassword(password : passwordTF.text!)){
            displayAlert(msg: "Enter Password of length more than 8")
        } else if(passwordTF.text! != confirmPasswordTF.text!){
            displayAlert(msg: "Password is Unmatched")
            
        }
        else if !emailIdTF.text!.contains("@") && !emailIdTF.text!.contains(".com") {
            displayAlert(msg: "Enter a valid email id")
        }
        else {
            if let mobile = Int64(mobileNumberTF.text!) {
            let userBackend = BackendlessUser()
            userBackend.setProperties(["name": fullNameTF.text!, "email": emailIdTF.text!, "password": passwordTF.text!, "mobile": mobile])
                _ = self.backendless?.userService.register(userBackend)
            displayAfterRegistered(msg: "Registered new user")
            }else{
                displayAlert(msg: "Enter valid mobile number")
            }
        }
    }
}












