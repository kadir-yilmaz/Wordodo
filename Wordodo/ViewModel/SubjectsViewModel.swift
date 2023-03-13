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
        Subject(subjectName: "My List", subjectTable: "user_table"),
        Subject(subjectName: "Verbs", subjectTable: "verbs"),
        Subject(subjectName: "Phrasal Verbs", subjectTable: "phrasal_verbs"),
        Subject(subjectName: "Idioms", subjectTable: "idioms"),
        Subject(subjectName: "Fruits", subjectTable: "fruits"),
        Subject(subjectName: "Vegetables", subjectTable: "vegetables"),
        Subject(subjectName: "Body", subjectTable: "body"),
        Subject(subjectName: "Jobs", subjectTable: "jobs"),
        Subject(subjectName: "Time", subjectTable: "time"),
        Subject(subjectName: "Clothes", subjectTable: "clothes"),
        Subject(subjectName: "Animals", subjectTable: "animals"),
        Subject(subjectName: "Insects", subjectTable: "insects"),
        Subject(subjectName: "Colors", subjectTable: "colors")
    ]

    private let colorArray = [
        UIColor.systemPink,
        UIColor.yellow,
        UIColor.green,
        UIColor.cyan,
        UIColor.magenta,
        UIColor.brown,
    ]

    func getSubjects() -> [Subject] {
        return subjects
    }

    func getColorArray() -> [UIColor] {
        return colorArray
    }

}
