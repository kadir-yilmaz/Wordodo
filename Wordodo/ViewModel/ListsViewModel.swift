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
    
    let userId = Auth.auth().currentUser!.uid
    
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
    
    private var listNameArray = [String]()

    func getColorArray() -> [UIColor] {
        return colorArray
    }
    
    func getListNames(completion: @escaping ([String]) -> Void) {
        WebService.shared.fetchListNames() { listNames in
            DispatchQueue.main.async {
                self.listNameArray = listNames
                completion(listNames)
            }
        }
    }
    
    func deleteList(listName: String, completion: @escaping (Bool, Error?) -> Void) {
        WebService.shared.deleteList(user_id: userId, list_name: listName) { success, error in
            completion(success, error)
        }
    }


}
