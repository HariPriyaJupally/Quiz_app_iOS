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
    }
    
    
    
}
