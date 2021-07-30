//
//  Constants.swift
//  FlashChat
//
//  Created by Binaya on 29/07/2021.
//

struct K {
    
    static let appName = "⚡️FLASH CHAT"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegueIdentifier = "RegisterToChat"
    static let loginSegueIdentifier = "LoginToChat"
    
    struct BrandColors {
        static let jadeDust = "JadeDust"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
}
