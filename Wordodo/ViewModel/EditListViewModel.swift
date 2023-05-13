//
//  EditListViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation

class EditListViewModel {
    func deleteWord(user_id: String, word_id: Int, list_name: String, completion: @escaping (Bool, Error?) -> Void) {
        WebService.shared.deleteWord(user_id: user_id, word_id: word_id, list_name: list_name) { success, error in
            if success {
                completion(success, error)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
