//
//  SettingsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 25.02.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    var settings = [Setting]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s1 = Setting(settingName: "👤   Profil Bilgileri")
        let s2 = Setting(settingName: "➡️   Çıkış Yap")
        
        settings.append(s1)
        settings.append(s2)

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
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
                self.performSegue(withIdentifier: "toVC", sender: nil)
            } catch  {
                print("error")
            }
        }
    }
    
}
