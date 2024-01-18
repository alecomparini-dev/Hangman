//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

public struct K {
    public static let identifierApp = "hangman"
    public static let cornerRadius: CGFloat = 15
    public static let errorCountToEndGame: Int = 6
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
        public static let hints = "Dicas"
        public static let hifen = "-"
        public static let life = "Vidas"
        public static let revealLetter = "Revelar Letra"
    }
    
    public struct Collections {
        public static let hangmanWords = "hangmanWords"
        public static let dolls = "dolls"
        public static let users = "users"
        public static let wordsPlayed = "wordsPlayed"
        public static let game = "game"
                
        public struct Documents {
            public static let help = "help"
        }
    }
    
    public struct Service {
        public static let fileNameJson = "HangmanWordsData"
        public static let extensionJson = "json"
    }
        
    public struct Images {
        public static let nextWordButton = "chevron.forward"
        public static let downButton = "chevron.down"
        public static let hint = ["lightbulb.max.fill", "lightbulb.fill"]
        public static let hintClose = ["lightbulb.max", "lightbulb"]
        public static let hintLocked = "lock.fill"
        public static let heartFill = "suit.heart.fill"
        public static let heartSlashFill = "heart.slash.fill"
        public static let eyeFill = "eye.fill"
        public static let eyeSlashFill = "eye.slash.fill"
        public static let triangleFill = "eject.fill"
        public static let handTapFill = "hand.tap.fill"
    }
    
    public struct ExtraColor {
        public static let heartFill = "#fe3400"
        public static let heartShadow = "#050505"
        public static let lightHints = "#68a4f0"
    }
    
    public struct ErrorLetters {
        public static let firstError: Int = 1
        public static let secondError: Int = 2
        public static let thirdError: Int = 3
        public static let fourthError: Int = 4
        public static let fifthError: Int = 5
        public static let sixthError: Int = 6
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

