//
//  SecondViewController.swift
//  Just Quizzing...
//
//  Created by student on 2/23/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var players = ["Hari Priya", "Hyndavi", "Sai Ram", "Indra"]
    var ranks = [1,2,3,4]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return players.count
        }  else {
            return -1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "players")!
        cell.textLabel?.text = players[indexPath.row]
        cell.detailTextLabel?.text = String(ranks[indexPath.row])
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    
}
