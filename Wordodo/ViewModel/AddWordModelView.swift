//
//  AddWordModelView.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation

class AddWordModelViewModel {
    
    func addWord(wordEn: String, wordTr: String, wordSentence: String, userId: String, listName: String, completion: @escaping (Error?) -> Void) {
        WebService.shared.addWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, userId: userId, listName: AddWordVC.listName) { error in
            if let error = error {
                print("Error adding word: \(error.localizedDescription)")
                completion(error)
            } else {
                if !wordEn.isEmpty && !wordTr.isEmpty {
                    completion(nil)
                }
            }
        }
    }

}
