//
//  LearningSubjectsViewController.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 1.03.2023.
//

import UIKit

class StudySubjectsViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var subjects = [Subject]()
    
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

extension StudySubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studySubjectCell", for: indexPath) as! StudySubjectTableViewCell
        
        cell.subjectImageView.image = UIImage(named: "\(subjects[indexPath.row].subjectName!).jpg")
        cell.subjectNameLabel.text = "\(subjects[indexPath.row].subjectName!)"
            
        return cell
    }
    
    
}
