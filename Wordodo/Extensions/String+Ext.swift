//
//  String+Ext.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 12.05.2023.
//

import Foundation
import FirebaseAuth

extension String {
    // boşluk url'de %20 ile temsil edilir
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
    
    // Extensions must not contain stored properties
    // var urlEncoded = return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self şeklinde tanımlama yapılamaz
    
}
