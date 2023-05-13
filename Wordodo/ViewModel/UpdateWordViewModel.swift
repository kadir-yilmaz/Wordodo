//
//  UpdateWordViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 13.05.2023.
//

import Foundation

class UpdateWordViewModel {
    
    func updateWord(wordEn: String, wordTr: String, wordSentence: String, userId: String, listName: String, wordId: Int, completion: @escaping (Error?) -> Void) {
        WebService.shared.updateWord(wordEn: wordEn, wordTr: wordTr, wordSentence: wordSentence, wordId: wordId, listName: UpdateWordVC.listName) { error in
            if let error = error {
                print("Error updating word: \(error.localizedDescription)")
            } else {
                if !wordEn.isEmpty && !wordTr.isEmpty {
                    completion(nil)
                }
            }
        }
    }
}
