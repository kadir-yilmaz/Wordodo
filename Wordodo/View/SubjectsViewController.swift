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
    
    var subjects = [Subject]()
    
    var colorArray = [UIColor]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let s1 = Subject(subjectName: "My List", subjectTable: "user_table")
        let s2 = Subject(subjectName: "Verbs", subjectTable: "verbs")
        let s3 = Subject(subjectName: "Phrasal Verbs", subjectTable: "phrasal_verbs")
        let s4 = Subject(subjectName: "Idioms", subjectTable: "idioms")
        let s5 = Subject(subjectName: "Fruits", subjectTable: "fruits")
        let s6 = Subject(subjectName: "Vegetables", subjectTable: "vegetables")
        let s7 = Subject(subjectName: "Body", subjectTable: "body")
        let s8 = Subject(subjectName: "Jobs", subjectTable: "jobs")
        let s9 = Subject(subjectName: "Time", subjectTable: "time")
        let s10 = Subject(subjectName: "Clothes", subjectTable: "clothes")
        let s11 = Subject(subjectName: "Animals", subjectTable: "animals")
        let s12 = Subject(subjectName: "Insects", subjectTable: "insects")
        let s13 = Subject(subjectName: "Colors", subjectTable: "colors")

        subjects.append(s1)
        subjects.append(s2)
        subjects.append(s3)
        subjects.append(s4)
        subjects.append(s5)
        subjects.append(s6)
        subjects.append(s7)
        subjects.append(s8)
        subjects.append(s9)
        subjects.append(s10)
        subjects.append(s11)
        subjects.append(s12)
        subjects.append(s13)
        
        self.colorArray = [
            UIColor(red: 145/255, green: 100/255, blue: 152/255, alpha: 1.0),
            UIColor.red,
            UIColor.green,
            UIColor.cyan,
            UIColor.yellow,
            UIColor.purple,
        ]


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
