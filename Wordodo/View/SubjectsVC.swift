//
//  LearningSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit
import FirebaseAuth

class SubjectsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = SubjectsViewModel()
    
    var subjects = [Subject]()
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        subjects = viewModel.getSubjects()
        colorArray = viewModel.getColorArray()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        print("VFDVVPJREPBJREPBJPEBJE")
        print(Auth.auth().currentUser!.uid)
        
        let alertController = UIAlertController(title: "Yeni Liste", message: "Eklenecek listenin adını giriniz.", preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            
            textfield.placeholder = "İsim"
            textfield.keyboardType = .emailAddress
            
        }
        
        let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in
            
        }
        
        let tamamAction = UIAlertAction(title: "Kaydet", style: .destructive) { action in
            
        }
        
        alertController.addAction(iptalAction)
        alertController.addAction(tamamAction)
        
        self.present(alertController, animated: true)
        
    }
    
}

extension SubjectsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySubjectCell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectNameLabel.text = "\(subjects[indexPath.row].subjectName!)"
        cell.backgroundColor = self.colorArray[indexPath.row % colorArray.count]
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userId = Auth.auth().currentUser!.uid
        let listName = subjects[indexPath.row].subjectName!
        UserWordListVC.listName = listName
        AddWordVC.listName = listName
        UpdateWordVC.listName = listName

        if let encodedListName = listName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            StudyVC.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?user_id=\(userId)&list_name=\(encodedListName)"
        }
        
        
        
        if indexPath.row == 0 {
            
            
        }
        

        
        
        
        performSegue(withIdentifier: "toStudyVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){
                    (UIContextualAction, view, boolValue) in
            
            let alertController = UIAlertController(title: "Sil", message: "Liste silinsin mi?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel) { action in
                
            }
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                
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
            let listName = self.subjects[indexPath.row].subjectName!
            
            print(userId)
            print(listName)
            
            if let encodedListName = listName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                QuizVC.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsRandom.php?user_id=\(userId)&list_name=\(encodedListName)"
                
                QuizVC.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWords.php?user_id=\(userId)&list_name=\(encodedListName)"
            }
            
            self.performSegue(withIdentifier: "toQuizVC", sender: nil)
                                
        }
                
        return UISwipeActionsConfiguration(actions: [quizAction])
    }
    
}
