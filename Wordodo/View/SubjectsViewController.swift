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
        
        let s1 = Subject(subjectName: "YDS & YÖKDiL")
        let s2 = Subject(subjectName: "Animals")
        let s3 = Subject(subjectName: "Colors")
        let s4 = Subject(subjectName: "Fruits-Vegetables")
        let s5 = Subject(subjectName: "Kitchen")
        let s6 = Subject(subjectName: "Verbs")
        let s7 = Subject(subjectName: "Phrasal Verbs")
        let s8 = Subject(subjectName: "Idioms")
        let s9 = Subject(subjectName: "Directions")
        let s10 = Subject(subjectName: "Body")
        let s11 = Subject(subjectName: "Jobs")
        let s12 = Subject(subjectName: "Transport")
        let s13 = Subject(subjectName: "Time")
        let s14 = Subject(subjectName: "Weather")
        let s15 = Subject(subjectName: "Clothes")
        let s16 = Subject(subjectName: "Family")
        let s17 = Subject(subjectName: "Hobby-Sports")
        let s18 = Subject(subjectName: "My List")

        

        
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
        subjects.append(s18)

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
        
        if indexPath.row == 1 {
            StudyViewController.url = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/getAllWordsFromAnimals.php"
        }
        
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
