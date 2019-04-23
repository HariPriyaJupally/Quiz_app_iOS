//
//  History.swift
//  Just Quizzing...
//
//  Created by student on 4/21/19.
//  Copyright © 2019 student. All rights reserved.
//
import Foundation

@objcMembers

class History : NSObject {
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
    
    override var description: String
    {
        return " totalScore:\(totalScore), score:\(score)"
    }
}


class LeaderBoard {
    let backendless = Backendless.sharedInstance()!
    
    var historyDataStore:IDataStore!
    
    var leaderboard: [History]
    
    var username: String
    var totalScores: Int
    var scoreObtained: Int
    
    static var shared = LeaderBoard()
    
    init(totalScore: Int, scoreObtained: Int){
        historyDataStore = backendless.data.of(History.ofClass())
        self.leaderboard = []
        self.username = Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String
        self.totalScores = totalScore
        self.scoreObtained = scoreObtained
    }
    
    private convenience init(){
        self.init(totalScore: 0, scoreObtained: 0)
    }
    
    func numHistory() -> Int {
        return leaderboard.count
    }
    
    func saveHistory(score: Int, totalScore: Int) {
        var historyToSave = History(score: score, totalScore: totalScore)
        //print(historyDataStore.save(historyToSave))
        backendless.data.of(History.ofClass()).save(historyToSave)
//leaderboard.append(historyToSave)
        saveToLeaderboard(user: Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String, leaderboard: leaderboard)
        
    }
    
    func retrieveAllQuizes() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setRelated(["leaderboard"])
        queryBuilder!.setPageSize(100)
        Types.tryblock({() -> Void in
            print(self.historyDataStore.find(queryBuilder))
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
