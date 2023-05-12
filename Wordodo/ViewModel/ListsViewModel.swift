//
//  SubjectsViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation
import UIKit
import FirebaseAuth

class ListsViewModel {
    
    
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



    func getColorArray() -> [UIColor] {
        return colorArray
    }

}
