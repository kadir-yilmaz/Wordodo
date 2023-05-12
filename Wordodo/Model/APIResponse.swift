//
//  JSONResponse.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 3.03.2023.
//

import Foundation

struct APIResponse: Codable {
    var words: [Word]?
    let list_names: [String]? // gelen JSON dizisinin ismi ile aynı olmalı
}
