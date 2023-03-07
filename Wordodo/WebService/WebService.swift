//
//  WebService.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import Foundation
import Alamofire

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
}

