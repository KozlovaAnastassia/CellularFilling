//
//  Constants.swift
//  cellularFilling
//
//  Created by Анастасия on 14.05.2024.
//

import UIKit

enum Constants {
    enum Errors {
        static let initError = "init(coder:) has not been implemented"
    }
    
    enum Title {
        static let buttonTitle = "Сотворить"
        static let headerTitle = "Клеточное наполнение"
        static let deadCellName = "Мёртвая"
        static let deadCellDescription = "или прикидывается"
        static let liveCellName = "Живая"
        static let liveCellDescription = "и шевелится!"
        static let lifeCellName = "Жизнь"
        static let lifeCellDescription = "Ку-ку!"
    }

    enum UniCodes {
        static let deadCellUniCode: Character = "💀"
        static let liveCellUniCode: Character = "💥"
        static let lifeCellUniCode: Character = "🐣"
    }
    
    enum Constraints {
        static let offset16: CGFloat = 16
        static let inset16: CGFloat = -16
    }
    
    enum Colors {
        static let customPurple =  UIColor(hexString: "#5A3472")
    }
    
    enum Font {
        static let titleFont = UIFont.systemFont(ofSize: 20, weight: .semibold)
        static let descriptionFont =  UIFont.systemFont(ofSize: 14, weight: .medium)
        static let headerFont = UIFont.systemFont(ofSize: 25, weight: .medium)
    }
}
