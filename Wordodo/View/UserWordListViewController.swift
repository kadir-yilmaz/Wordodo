//
//  UserWordListViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit
import Alamofire
import FirebaseAuth

class UserWordListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
        
    
    var words = [Word]()
    
    var searchText: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        loadWords()
        tableView.reloadData()
        aramaYap(aramaKelimesi: searchText)
    }
    
    func loadWords()  {
            WebService.shared.loadWords { [weak self] (words) in
                if let words = words {
                    self?.words = words
                    self?.tableView.reloadData()
                }
            }
        }
        
        func aramaYap(aramaKelimesi:String){
            WebService.shared.aramaYap(aramaKelimesi: aramaKelimesi) { [weak self] (words) in
                if let words = words {
                    self?.words = words
                    self?.tableView.reloadData()
                }
            }
        }
    
}

extension UserWordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userWordCell", for: indexPath) as! UserWordTableViewCell
        
        cell.indexLabel.text = "\(indexPath.row + 1)"
        
        cell.wordCard.wordLabel.text = words[indexPath.row].wordEn
        cell.wordCard.meaningLabel.text = words[indexPath.row].wordTr
        
        //cell.wordEnLabel.text = words[indexPath.row].wordEn
       // cell.wordTrLabel.text = words[indexPath.row].wordTr
        
        cell.wordSentenceTextView.text = words[indexPath.row].wordSentence
        
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){
                    (UIContextualAction, view, boolValue) in
            
            let wordId = Int(self.words[indexPath.row].wordId!)!
            
            
            
            print(Auth.auth().currentUser!.uid)

            AF.request("https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/deleteWord.php?user_id=\(Auth.auth().currentUser!.uid)&word_id=\(wordId)", method: .post).response { response in
                if let data = response.data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            print(json)
                            self.words.remove(at: indexPath.row)
                            tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }

        }
                
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let updateAction = UIContextualAction(style: .normal, title: "Güncelle"){
                    (UIContextualAction, view, boolValue) in
            
            UpdateWordViewController.gelenWordEn = self.words[indexPath.row].wordEn!
            UpdateWordViewController.gelenWordTr = self.words[indexPath.row].wordTr!
            UpdateWordViewController.gelenWordSentence = self.words[indexPath.row].wordSentence ?? ""
            UpdateWordViewController.gelenWordId = Int(self.words[indexPath.row].wordId!)!

            self.performSegue(withIdentifier: "toUpdateWordVC", sender: nil)
            
                                
        }
                
        return UISwipeActionsConfiguration(actions: [updateAction])
        
    }
    
}

extension UserWordListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonucu : \(searchText)")
        
        self.searchText = searchText
        aramaYap(aramaKelimesi: searchText)
    }
    
}
