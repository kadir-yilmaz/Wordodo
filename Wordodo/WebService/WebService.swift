//
//  WebService.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import Foundation
import Alamofire
import FirebaseAuth
import FirebaseFirestore

class WebService {
    
    static let shared = WebService()
    
    func loadWords(from url: String, completion: @escaping ([Word]?, Error?) -> Void) {
        AF.request(url, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(JSONResponse.self, from: data)
                    if let gelenKelimeListesi = cevap.words {
                        completion(gelenKelimeListesi, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getWrongWords(forWordId wordId: Int, from url: String, completion: @escaping ([Word]?, Error?) -> Void) {
        let urlWithParams = "\(url)&word_id=\(wordId)"
        AF.request(urlWithParams, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(JSONResponse.self, from: data)
                    if let gelenKelimeListesi = cevap.words {
                        completion(gelenKelimeListesi, nil)
                    }
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    func addWord(wordEn: String, wordTr: String, wordSentence: String, userId: String, completion: @escaping (Error?) -> Void) {
        let urlString = "https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/insertWord.php"
        
        let parameters: [String: Any] = [
            "word_en": wordEn,
            "word_tr": wordTr,
            "word_sentence": wordSentence,
            "user_id": userId
        ]
        
        AF.request(urlString,method: .post,parameters: parameters).response { response in
            
            if let error = response.error {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }

    
    func updateWord(wordEn: String, wordTr: String, wordSentence: String, wordId: Int, completion: @escaping (Error?) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            completion(NSError(domain: "CurrentUserNotFound", code: 0, userInfo: nil))
            return
        }
        
        let parameters: [String: Any] = [
            "user_id": currentUserID,
            "word_id": wordId,
            "word_en": wordEn,
            "word_tr": wordTr,
            "word_sentence": wordSentence
        ]
        
        AF.request("https://kadiryilmazhatay.000webhostapp.com/WordodoWebService/updateWord.php", method: .post, parameters: parameters).response { response in
            if let error = response.error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

}

