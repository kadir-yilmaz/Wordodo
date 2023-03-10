//
//  SettingsViewModel.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 10.03.2023.
//

import Foundation

class SettingsViewModel {
    
    var settings = [Setting]()

    
    func fetchSettings() -> [Setting] {
        let s1 = Setting(settingName: "👤   Profil Bilgileri")
        let s2 = Setting(settingName: "➡️   Çıkış Yap")
        
        settings.append(s1)
        settings.append(s2)
        
        return settings
    }
}
