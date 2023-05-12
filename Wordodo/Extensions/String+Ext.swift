//
//  String+Ext.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 12.05.2023.
//

import Foundation

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
    }
}
