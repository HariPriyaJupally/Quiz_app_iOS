//
//  ResultViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

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
