//
//  ViewController.swift
//  Just Quizzing...
//
//  Created by student on 2/25/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return LeaderBoard.shared.leaderboard.count
        }  else {
            return -1
        }
    }

   
    @IBOutlet weak var historytableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        historytableView.reloadData()
    }
    
    //The total score of each quiz of a user is displayed using this method.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "histories")!
        cell.textLabel?.text = "Quiz \(indexPath.row+1)"
        cell.detailTextLabel?.text = "\(LeaderBoard.shared.leaderboard[indexPath.row].score)/\(LeaderBoard.shared.leaderboard[indexPath.row].totalScore)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LeaderBoard.shared.retrieveCurrentUserQuizes()
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
        LeaderBoard.shared.retrieveCurrentUserQuizes()
    
    }
    
    
    
    @IBAction func reloadBTN(_ sender: Any) {
        LeaderBoard.shared.retrieveCurrentUserQuizes()
        historytableView.reloadData()
    }
    
    
}
