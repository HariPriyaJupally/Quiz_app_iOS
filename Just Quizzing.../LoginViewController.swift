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
        
        let backgroundImage = UIImage(named: "quizwallpaper.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
    
    
    
    
    }
    
    
    func display(title:String, msg:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBAction func loginBtn(_ sender: Any) {
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
//
//        },error: { fault in
//            self.display(title: "Login Failed", msg: (fault?.message!)!)
//
//        })
    }
    
    
    
    
    @IBAction func register(segue:UIStoryboardSegue){}
    @IBAction func cancel(segue:UIStoryboardSegue){}
    
}



