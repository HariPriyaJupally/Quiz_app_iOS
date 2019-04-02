//
//  ViewController.swift
//  Just Quizzing...
//
//  Created by Shruthi  Patlolla on 2/25/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var history = ["Hari Priya", "Indra"]
    
    var scores = [1,2,3,4]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return history.count
        }  else {
            return -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histories")!
        cell.textLabel?.text = history[indexPath.row]
        cell.detailTextLabel?.text = String(scores[indexPath.row])
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let backgroundImage = UIImage(named: "mzl.ulplplbr.png")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
    
    
    
    
    }
    
    
    
}
