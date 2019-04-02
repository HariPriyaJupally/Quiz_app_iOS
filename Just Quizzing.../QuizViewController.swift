//
//  QuizViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Result.shared.results.count

    }
    
    @IBOutlet weak var questionsTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questions")!
        cell.textLabel?.text = Result.shared.results[indexPath.row].difficulty
        return cell
    }
    

    var apiURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.dataSource = self
        questionsTableView.delegate = self
        let urlSession = URLSession.shared
        let url = URL(string: apiURL)!
        urlSession.dataTask(with: url, completionHandler: showData).resume()
        // Do any additional setup after loading the view.
    }
    
    func showData(data:Data?, urlResponse:URLResponse?, error:Error?){
        do {
            let decoder = JSONDecoder()
            let questions = try decoder.decode([Quiz].self, from: data!)
            DispatchQueue.main.async {
                self.questionsTableView.reloadData()
            }
        }catch {
            print(error)
        }
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
