//
//  Word.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import Foundation

class Word: Codable {
    
    var wordId: String?
    var wordEn: String?
    var wordTr: String?
    var wordSentence: String?
    
    init(wordId: String? = nil, wordEn: String? = nil, wordTr: String? = nil, wordSentence: String? = nil) {
        self.wordId = wordId
        self.wordEn = wordEn
        self.wordTr = wordTr
        self.wordSentence = wordSentence
    }
    
    init(){
        
    }
}
