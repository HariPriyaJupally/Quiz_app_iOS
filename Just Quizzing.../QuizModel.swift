//
//  QuizModel.swift
//  Just Quizzing...
//
//  Created by Jupally,Hari Priya on 4/1/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct Quiz : Codable {
    var category:String
    var type:String
    var difficulty:String
    var question:String
    var correct_answer:String
    var incorrect_answers:[String]
}

struct Result : Codable {
    var response_code:String
    var results: [Quiz]
    static var shared = Result()
    init() {
        self.response_code = ""
        self.results = []
    }
    
    init(response_code:String, results:[Quiz]) {
        self.response_code = response_code
        self.results = results
    }
    
    mutating func addQuiz(quiz: Quiz){
        results.append(quiz)
    }
    
}

@objcMembers
class History: NSObject {
    var score: Int
    var totalScore: Int
    
    var objectId: String?
    
    init(score: Int, totalScore: Int){
        self.totalScore = totalScore
        self.score = score
    }
    
    convenience override init(){
        self.init(score: 0, totalScore: 0)
    }
}

@objcMembers
class LeaderBoard: NSObject {
    let backendless = Backendless.sharedInstance()!
    
    var historyDataStore:IDataStore!
    
    var leaderboard: [History]
    
    var username: String
    var totalScores: Int
    var scoreObtained: Int
    
    static var shared = LeaderBoard()
    
    init(totalScore: Int, scoreObtained: Int){
        historyDataStore = backendless.data.of(History.self)
        self.leaderboard = []
        self.username = Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String
        self.totalScores = totalScore
        self.scoreObtained = scoreObtained
    }
    
    convenience override init(){
        self.init(totalScore: 0, scoreObtained: 0)
    }
    
    func numHistory() -> Int {
        return leaderboard.count
    }
    
    func saveHistory(score: Int, totalScore: Int) {
        let historyToSave = History(score: score, totalScore: totalScore)
        historyDataStore.save(historyToSave)
        leaderboard.append(historyToSave)
        saveToLeaderboard(user: Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String, leaderboard: leaderboard)
        print(historyToSave)
    }
    
    func retrieveAllQuizes() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["leaderboard"])
        queryBuilder!.setPageSize(100)
        Types.tryblock({() -> Void in
            self.leaderboard = self.historyDataStore.find(queryBuilder) as! [History]
            print(self.leaderboard)
        },
            catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllQuizes()")})
    }
    
    func saveToLeaderboard(user: String,leaderboard: [History] ){
        var scoreObtained = 0
        var totalScores = 0
        for i in leaderboard {
            scoreObtained += i.score
            totalScores += i.totalScore
        }
        self.scoreObtained = scoreObtained
        self.totalScores = totalScores
        if Users.shared.users.isEmpty {
            Users.shared.users.append(LeaderBoard(totalScore: totalScores, scoreObtained: scoreObtained))
        }else{
            for i in 0..<Users.shared.users.count {
                if Users.shared.users[i].username.elementsEqual(user){
                    Users.shared.users[i] = LeaderBoard( totalScore: totalScores, scoreObtained: scoreObtained)
                }else{
                    Users.shared.users.append(LeaderBoard(totalScore: totalScores, scoreObtained: scoreObtained))
                }
            }
        }
    }
}

class Users {
    
    var users: [LeaderBoard]
    
    static var shared = Users()
    
    init(){
        users = []
    }
    
    
}


