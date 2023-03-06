//
//  Subject.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import Foundation

class Subject {
    var subjectName: String?
    var subjectTable: String?
    
    init(subjectName: String? = nil, subjectTable: String? = nil) {
        self.subjectName = subjectName
        self.subjectTable = subjectTable
    }
    
}
