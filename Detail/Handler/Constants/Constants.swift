//
//  Constants.swift
//  Detail
//
//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

struct K {
    static let identifierApp = "hangman"
    
    static let cornerRadius: CGFloat = 15
    static let errorCountToEndGame: Int8 = 6
//    static let quantityLetterByLine: Int = 14
    static let quantityLetterByLine: Int = 7
    static let angleDollFailure: Double = 75
    
    struct String {
        static let dot = "."
        static let comma = ","
        static let zeroDouble = "0.0"
        static let zero = "0"
        static let empty = ""
        static let one = "1"
        static let two = "2"
        static let three = "3"
        static let four = "4"
        static let five = "5"
        static let six = "6"
        static let seven = "7"
        static let eight = "8"
        static let nine = "9"
        static let tips = "Dicas"
    }
    
    struct Service {
        static let fileNameJson = "HangmanWordsData"
        static let extensionJson = "json"
    }
    
    struct FloatView {
        static let x: CGFloat = 30
        static let y: CGFloat = 30
        static let width: CGFloat = 290
        static let height: CGFloat = 550
    }
    
    struct Images {
        static let nextWordButton = "chevron.forward"
        static let moreTipButton = "lightbulb.fill"
    }
    
    struct ErrorLetters {
        static let firstError: Int8 = 1
        static let secondError: Int8 = 2
        static let thirdError: Int8 = 3
        static let fourthError: Int8 = 4
        static let fifthError: Int8 = 5
        static let sixthError: Int8 = 6
    }
    
    struct MoreTip {
        static let margin: CGFloat = 13
        static let positionX: CGFloat = 6
        static let positionY: CGFloat = 4
    }
    
    struct Animation {
        struct Delay {
            static let standard : Double = 0
        }
        struct Duration {
            static let revealLetter: Double = 1
            static let standard: Double = 0.5
            static let hide: Double = 0.3
        }
    }
    
}

