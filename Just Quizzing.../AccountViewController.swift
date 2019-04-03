//
//  AccountViewController.swift
//  Just Quizzing...
//
//  Created by Jupally,Hari Priya on 4/2/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "quizwallpaper.jpg")
        
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
