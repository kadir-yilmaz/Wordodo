//
//  UserWordListViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import Alamofire
import FirebaseAuth

class UserWordListVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        
    var words = [Word]()
    static var listName = "My List"
    
    let userId = Auth.auth().currentUser!.uid
    
    var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        aramaYap(aramaKelimesi: searchText)
        print(words.count)
        
    }
    
    func aramaYap(aramaKelimesi:String){
        WebService.shared.search(aramaKelimesi: aramaKelimesi, listName: UserWordListVC.listName) { (words) in
            if let words = words {
                self.words = words
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}

extension UserWordListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userWordCell", for: indexPath) as! UserWordTableViewCell
        
        cell.wordCard.wordLabel.text = words[indexPath.row].wordEn
        cell.wordCard.meaningLabel.text = words[indexPath.row].wordTr
        cell.wordSentenceTextView.text = words[indexPath.row].wordSentence
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){ [self]
                    (UIContextualAction, view, boolValue) in
            
            let wordId = Int(self.words[indexPath.row].wordId!)!
            
            let alertController = UIAlertController(title: "Sil", message: "\(self.words[indexPath.row].wordEn!) kelimesi silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in
                
            }
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
              
                WebService.shared.deleteWord(user_id: Auth.auth().currentUser!.uid, word_id: Int(wordId), list_name: UserWordListVC.listName) { success, error in
                        if success {
                            print("BAŞARILI BAŞARILI BAŞARILI")
                            self.words.remove(at: indexPath.row)
                            tableView.reloadData()
                        } else if let error = error {
                            print("ERRORRRRRRR")
                            print(error.localizedDescription)
                            
                        }
                    }
            }
                
            
            alertController.addAction(iptalAction)
            alertController.addAction(evetAction)
            
            self.present(alertController, animated: true)
            
        }
                
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let updateAction = UIContextualAction(style: .normal, title: "Güncelle"){
                    (UIContextualAction, view, boolValue) in
            
            UpdateWordVC.gelenWordEn = self.words[indexPath.row].wordEn!
            UpdateWordVC.gelenWordTr = self.words[indexPath.row].wordTr!
            UpdateWordVC.gelenWordSentence = self.words[indexPath.row].wordSentence ?? ""
            UpdateWordVC.gelenWordId = Int(self.words[indexPath.row].wordId!)!

            self.performSegue(withIdentifier: "toUpdateWordVC", sender: nil)
            
        }
                
        return UISwipeActionsConfiguration(actions: [updateAction])
        
    }
    
}

extension UserWordListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        aramaYap(aramaKelimesi: searchText)
    }
    
    
}
