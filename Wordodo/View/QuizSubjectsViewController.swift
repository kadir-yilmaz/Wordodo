//
//  QuizSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import UIKit

class QuizSubjectsViewController: UIViewController {
    
    var subjects = [Subject]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let s1 = Subject(subjectName: "Animals")
        
        subjects.append(s1)
        subjects.append(s1)
        subjects.append(s1)

        
        

    }
    
}

extension QuizSubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizSubjectCell", for: indexPath) as! QuizSubjectTableViewCell
        
        cell.subjectImageView.image = UIImage(named: "\(subjects[indexPath.row].subjectName!).jpg")
        cell.subjectNameLabel.text = "\(subjects[indexPath.row].subjectName!)"
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toQuizVC", sender: nil)
    }
    
    
    
}
