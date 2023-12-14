//
//  Constants.swift
//  Detail
//
//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

public struct K {
    public static let identifierApp = "hangman"
    public static let cornerRadius: CGFloat = 15
    public static let errorCountToEndGame: Int8 = 6
    public static let quantityLetterByLine: Int = 12
    public static let quantityWordsToFetch: Int = 20
    public static let angleDollFailure: Double = 75
    
    public struct String {
        public static let dot = "."
        public static let comma = ","
        public static let zeroDouble = "0.0"
        public static let zero = "0"
        public static let empty = ""
        public static let one = "1"
        public static let two = "2"
        public static let three = "3"
        public static let four = "4"
        public static let five = "5"
        public static let six = "6"
        public static let seven = "7"
        public static let eight = "8"
        public static let nine = "9"
        public static let tips = "Dicas"
        public static let hifen = "-"
    }
    
    public struct Service {
        public static let fileNameJson = "HangmanWordsData"
        public static let extensionJson = "json"
    }
    
    public struct FloatView {
        public static let x: CGFloat = 30
        public static let y: CGFloat = 30
        public static let width: CGFloat = 290
        public static let height: CGFloat = 550
    }
    
    public struct Images {
        public static let nextWordButton = "chevron.forward"
        public static let light = ["lightbulb.max.fill", "lightbulb.fill"]
        public static let heartFill = "suit.heart.fill"
        public static let eyeFill = "eye.fill"
    }
    
    public struct ExtraColor {
        public static let heartFill = "#fe3400"
        public static let heartShadow = "#050505"
        public static let lightTips = "#68a4f0"
    }
    
    public struct ErrorLetters {
        public static let firstError: Int8 = 1
        public static let secondError: Int8 = 2
        public static let thirdError: Int8 = 3
        public static let fourthError: Int8 = 4
        public static let fifthError: Int8 = 5
        public static let sixthError: Int8 = 6
    }
    
    public struct MoreTip {
        public static let margin: CGFloat = 13
        public static let positionX: CGFloat = 6
        public static let positionY: CGFloat = 4
    }
    
    public struct Animation {
        public struct Delay {
            public static let standard : Double = 0
        }
        
        public struct Duration {
            public static let revealLetter: Double = 1
            public static let standard: Double = 0.5
            public static let increment: Double = 0.5
            public static let hide: Double = 0.3
        }
    }
    
    public struct Keyboard {
        public static let letter = [
            "A": 1 ,
            "B": 2 ,
            "C": 3 ,
            "D": 4 ,
            "E": 5 ,
            "F": 6 ,
            "G": 7 ,
            "H": 8 ,
            "I": 9 ,
            "J": 10 ,
            "K": 11 ,
            "L": 12 ,
            "M": 13 ,
            "N": 14 ,
            "O": 15 ,
            "P": 16 ,
            "Q": 17 ,
            "R": 18 ,
            "S": 19 ,
            "T": 20 ,
            "U": 21 ,
            "V": 22 ,
            "W": 23 ,
            "X": 24 ,
            "Y": 25 ,
            "Z": 26
        ]
    }
    
}

