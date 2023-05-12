//
//  SubjectsViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation
import UIKit

class SubjectsViewModel {

    private let subjects = [
        Subject(subjectName: "My List", subjectTable: "My List"),
        Subject(subjectName: "Phrasal Verbs", subjectTable: "phrasal_verbs"),
        Subject(subjectName: "Idioms", subjectTable: "idioms"),
        Subject(subjectName: "Body", subjectTable: "body"),
        Subject(subjectName: "Fruits", subjectTable: "fruits"),
        Subject(subjectName: "Vegetables", subjectTable: "vegetables"),
        Subject(subjectName: "Animals", subjectTable: "animals"),
        Subject(subjectName: "Insects", subjectTable: "insects"),
    ]

    private let colorArray = [
        UIColor.systemPink,
        UIColor.yellow,
        UIColor.green,
        UIColor.cyan,
        UIColor.magenta,
        UIColor.brown,
        UIColor.systemTeal,
        UIColor.systemPurple,
        UIColor.systemOrange,
        UIColor.systemIndigo
    ]

    func getSubjects() -> [Subject] {
        return subjects
    }

    func getColorArray() -> [UIColor] {
        return colorArray
    }

}
