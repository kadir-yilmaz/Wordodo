//
//  LearningSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit

class SubjectsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var subjects = [Subject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let s1 = Subject(subjectName: "A1-A2")
        let s2 = Subject(subjectName: "B1-B2")
        let s3 = Subject(subjectName: "C1-C2")
        let s4 = Subject(subjectName: "Phrasal Verbs")
        let s5 = Subject(subjectName: "Idioms")
        let s6 = Subject(subjectName: "Animals")
        let s7 = Subject(subjectName: "Kitchen")

        
        subjects.append(s1)
        subjects.append(s2)
        subjects.append(s3)
        subjects.append(s4)
        subjects.append(s5)
        subjects.append(s6)
        subjects.append(s7)


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
        performSegue(withIdentifier: "toStudyVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let quizAction = UIContextualAction(style: .normal, title: "Quiz"){
                    (UIContextualAction, view, boolValue) in
            
            self.performSegue(withIdentifier: "toQuizVC", sender: nil)
                                
        }
                
        return UISwipeActionsConfiguration(actions: [quizAction])
    }
    
    
}
