//
//  LearningSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit
import FirebaseAuth

class ListsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let userId = Auth.auth().currentUser!.uid
    var viewModel = ListsViewModel()
    
    var listNames = [String]()
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.colorArray = self.viewModel.getColorArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadWords()
    }
    
    func loadWords() {
        viewModel.getListNames { listNames in
            self.listNames = listNames
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        showAlert()
    }

    func showAlert() {
        let alertController = UIAlertController(title: "Yeni Liste", message: "Eklenecek listenin adını giriniz.", preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "My List"
        }
        
        let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in }
        
        let kaydetAction = UIAlertAction(title: "Kaydet", style: .destructive) { action in
            if let alinanVeri = alertController.textFields?.first?.text {
                self.listNames.append(alinanVeri)
                self.tableView.reloadData()
            }
        }
        
        alertController.addAction(iptalAction)
        alertController.addAction(kaydetAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
}

extension ListsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySubjectCell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectNameLabel.text = "\(listNames[indexPath.row])"
        cell.backgroundColor = self.colorArray[indexPath.row % colorArray.count]
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listName = listNames[indexPath.row]
        
        EditListVC.listName = listName
        AddWordVC.listName = listName
        UpdateWordVC.listName = listName
        
        let encodedListName = listName.urlEncoded
        
        StudyVC.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?user_id=\(userId)&list_name=\(encodedListName)"
        
        performSegue(withIdentifier: "toStudyVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){
                    (UIContextualAction, view, boolValue) in
            
            let alertController = UIAlertController(title: "Sil", message: "\(self.listNames[indexPath.row]) listesi silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in
                
            }
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                
                self.viewModel.deleteList(listName: self.listNames[indexPath.row]) { success, error in
                    if success {
                        print("Liste başarıyla silindi.")
                        self.listNames.remove(at: indexPath.row)
                        tableView.reloadData()
                    } else if let error = error {
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
        
        let quizAction = UIContextualAction(style: .normal, title: "Quiz"){
                    (UIContextualAction, view, boolValue) in
            
            let userId = Auth.auth().currentUser!.uid
            let listName = self.listNames[indexPath.row]
            let encodedListName = listName.urlEncoded
            
            QuizVC.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsRandom.php?user_id=\(userId)&list_name=\(encodedListName)"
            
            QuizVC.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWords.php?user_id=\(userId)&list_name=\(encodedListName)"
            
            self.performSegue(withIdentifier: "toQuizVC", sender: nil)
        }
                
        return UISwipeActionsConfiguration(actions: [quizAction])
    }
    
}
