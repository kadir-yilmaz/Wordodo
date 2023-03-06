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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let s1 = Subject(subjectName: "YDS & YÖKDiL", subjectTable: "yds")
        let s2 = Subject(subjectName: "Animals", subjectTable: "animals")
        let s3 = Subject(subjectName: "Fruits", subjectTable: "fruits")
        let s4 = Subject(subjectName: "Vegetables", subjectTable: "vegetables")
        let s5 = Subject(subjectName: "Kitchen", subjectTable: "kitchen")
        let s6 = Subject(subjectName: "Verbs", subjectTable: "verbs")
        let s7 = Subject(subjectName: "Phrasal Verbs", subjectTable: "phrasal_verbs")
        let s8 = Subject(subjectName: "Idioms", subjectTable: "idioms")
        let s9 = Subject(subjectName: "Directions", subjectTable: "directions")
        let s10 = Subject(subjectName: "Body", subjectTable: "body")
        let s11 = Subject(subjectName: "Jobs", subjectTable: "jobs")
        let s12 = Subject(subjectName: "Transport", subjectTable: "transport")
        let s13 = Subject(subjectName: "Time", subjectTable: "time")
        let s14 = Subject(subjectName: "Weather", subjectTable: "weather")
        let s15 = Subject(subjectName: "Clothes", subjectTable: "clothes")
        let s16 = Subject(subjectName: "Family", subjectTable: "family")
        let s17 = Subject(subjectName: "My List", subjectTable: "user_table")

        

        
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
        subjects.append(s14)
        subjects.append(s15)
        subjects.append(s16)
        subjects.append(s17)

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
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 16 {
            StudyViewController.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?table=\(subjects[indexPath.row].subjectTable!)"
        }
        
        if indexPath.row == 16 {
            StudyViewController.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
        }
        
        
        performSegue(withIdentifier: "toStudyVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let quizAction = UIContextualAction(style: .normal, title: "Quiz"){
                    (UIContextualAction, view, boolValue) in
            
            if indexPath.row != 16 {
                QuizViewController.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWords.php?table=\(self.subjects[indexPath.row].subjectTable!)"
                QuizViewController.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWords.php?table=\(self.subjects[indexPath.row].subjectTable!)"
            }
            
            if indexPath.row == 16 {
                QuizViewController.url1 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
                QuizViewController.url2 = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/get3WrongWordsWithId.php?user_id=\(Auth.auth().currentUser!.uid)"
            }
            
            
            
            self.performSegue(withIdentifier: "toQuizVC", sender: nil)
                                
        }
                
        return UISwipeActionsConfiguration(actions: [quizAction])
    }
    
    
    
}
