//
//  LearningSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit
import FirebaseAuth

class SubjectsViewController: UIViewController {

    
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
    
}

extension SubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySubjectCell", for: indexPath) as! SubjectTableViewCell
        
        cell.subjectImageView.image = UIImage(named: "\(subjects[indexPath.row].subjectName!).jpg")
        cell.subjectNameLabel.text = "\(subjects[indexPath.row].subjectName!)"
        cell.backgroundColor = self.colorArray[indexPath.row % 6]

            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            StudyViewController.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?table=\(subjects[indexPath.row].subjectTable!)"
        }
        
        if indexPath.row == 0 {
            StudyViewController.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
        }
        
        
        performSegue(withIdentifier: "toStudyVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let quizAction = UIContextualAction(style: .normal, title: "Quiz"){
                    (UIContextualAction, view, boolValue) in
            
            if indexPath.row != 0 {
                QuizViewController.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?table=\(self.subjects[indexPath.row].subjectTable!)"
                QuizViewController.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWords.php?table=\(self.subjects[indexPath.row].subjectTable!)"
            }
            
            if indexPath.row == 0 {
                QuizViewController.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
                QuizViewController.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
            }
            
            
            
            self.performSegue(withIdentifier: "toQuizVC", sender: nil)
                                
        }
                
        return UISwipeActionsConfiguration(actions: [quizAction])
    }
    
    
    
}
