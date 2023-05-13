//
//  SettingsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 25.02.2023.
//

import UIKit
import FirebaseAuth

class SettingsVC: UIViewController {

    var settings = [Setting]()
    var viewModel = SettingsViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        settings = viewModel.fetchSettings()
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingTableViewCell
        cell.settingLabel.text = settings[indexPath.row].settingName
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toProfileVC", sender: nil)
        }
        
        if indexPath.row == 1 {
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "toSignInVC", sender: nil)
            } catch  {
                print("error")
            }
        }
    }
    
}
