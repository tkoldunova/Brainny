//
//  Language.swift
//  Brainny
//
//  Created by Tanya Koldunova on 04.12.2024.
//

import Foundation


enum Language: String, CaseIterable, Codable {
    case en = "en"
    case ru = "ru"
    case ua = "uk"
    
    var abbr:String {
        switch self {
        case .en: return "US"
        case .ru: return "RU"
        case .ua: return "UA"
        }
    }
    
    var language:String {
        switch self {
        case .en: return NSLocalizedString("language.language.en", comment: "")
        case .ru: return NSLocalizedString("language.language.ru", comment: "")
        case .ua: return NSLocalizedString("language.language.uk", comment: "")
        }
    }
    

}
