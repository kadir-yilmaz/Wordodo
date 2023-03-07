//
//  RanksViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 5.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RanksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let db = Firestore.firestore()
        db.collection("users").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.users = documents.map { document in
                let data = document.data()
                let userName = data["user_name"] as? String ?? "Unknown"
                let userScore = data["user_score"] as? Int ?? 0
                return User(userName: userName, userScore: userScore)
            }.sorted(by: { $0.userScore! > $1.userScore! })
            
            self.tableView.reloadData()
        }

    }

}

extension RanksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as! RankTableViewCell

        cell.userNameLabel.text = "\(indexPath.row + 1).    \(users[indexPath.row].userName!)"
        cell.userScoreLabel.text = "\(users[indexPath.row].userScore!)"
        
        return cell
    }
    
}
