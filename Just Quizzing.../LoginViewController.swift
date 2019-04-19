//
//  LoginViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/8/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var rememberMESwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpeg")!)
        // Do any additional setup after loading the view.
        
        let backgroundImage = UIImage(named: "board.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
    
    
    }
    
    
    func display(msg:String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func isValidPassword(password:String) -> Bool{
        return password.count >= 8
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        if userNameTF.text!.isEmpty || passwordTF.text!.isEmpty {
            display(msg: "Enter values for all fields or if new user click on SignUp")
        }
        else if userNameTF.text!.isEmpty {
            display(msg: "Enter UserName or if new user click on SignUp")
        }
        else if passwordTF.text!.isEmpty {
            display(msg: "Enter a valid password")
        }
        else {
            
            Backendless.sharedInstance().userService.login(userNameTF.text!,
                                                           password:passwordTF.text!)
        }
            
        }
        
        
//        Backendless.sharedInstance().userService.login(userNameTF.text!,
//                                                       password:passwordTF.text!,
//                                                       response: { user in
//                                                        if user != nil {
//                                                            if self.rememberMESwitch.isOn {
//                                                                Backendless.sharedInstance()?.userService.setStayLoggedIn(true)
//                                                            } else {
//                                                                Backendless.sharedInstance()?.userService.setStayLoggedIn(false)
//                                                            }
//                                                            self.performSegue(withIdentifier: "login", sender: user)
//                                                        }
        
//        },error: { fault in
//            self.display(msg: (fault?.message!)!)
//
//        })
    
    
    
    
    @IBAction func register(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    

}


