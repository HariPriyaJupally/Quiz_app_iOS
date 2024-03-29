//
//  ResultViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

import DLRadioButton

class ResultViewController: UIViewController {
    var result: Int!
    

    @IBOutlet weak var scoreLBL: UILabel!
    
    //In this function after the view is loaded the score for that particular quiz is displayed.
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let backgroundImage = UIImage(named: "greylights.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
        scoreLBL.text = "\(result!)"
        // Do any additional setup after loading the view.
    }
    

}
