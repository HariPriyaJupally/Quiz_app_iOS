//
//  AccountViewController.swift
//  Just Quizzing...
//
//  Created by Jupally,Hari Priya on 4/2/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    //@IBOutlet weak var usernameLBL: UITextField!
    @IBOutlet weak var usernameLBL: UILabel!
    
    //@IBOutlet weak var emailLBL: UITextField!
    @IBOutlet weak var emailLBL: UILabel!
    
    //@IBOutlet weak var phoneLBL: UITextField!
    
    @IBOutlet weak var phoneLBL: UILabel!
    
    //In this function the account details of that user are displayed.
    
    override func viewWillAppear(_ animated: Bool) {
        usernameLBL.text = Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as? String
        emailLBL.text = Backendless.sharedInstance()?.userService.currentUser.getProperty("email") as? String
        phoneLBL.text = Backendless.sharedInstance()?.userService.currentUser.getProperty("mobile") as? String
        }
    
//    @IBAction func logOutBTN(_ sender: Any) {
//        Backendless.sharedInstance()!.userService.logout()
//    }
    
    
    @IBAction func logOutBTN(_ sender: Any) {
        Backendless.sharedInstance()!.userService.logout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "board.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
