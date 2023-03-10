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
    
    let viewModel = RanksViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.fetchUsers { error in
            if let error = error {
                print("Error fetching users: \(error.localizedDescription)")
            } else {
                self.users = self.viewModel.users
                self.tableView.reloadData()
            }
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
