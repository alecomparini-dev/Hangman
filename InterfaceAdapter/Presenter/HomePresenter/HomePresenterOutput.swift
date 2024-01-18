//  Created by Alessandro Comparini on 28/12/23.
//

import Foundation

public protocol HomePresenterOutput: AnyObject {
    
    func successFetchNextWord(word: WordPresenterDTO?)
    func nextWordIsOver(title: String, message: String)
    func errorFetchNextWords(title: String, message: String)
    
    func fetchGameHelpSuccess(_ gameHelp: GameHelpPresenterDTO)
    func updateLivesCount(_ count: String)
    func updateHintsCount(_ count: String)
    func updateRevelationsCount(_ count: String)
    
    func updateCountCorrectLetters(_ count: String)
    func markChosenKeyboardLetter(isCorrect: Bool, _ keyboardLetter: String)
    func revealCorrectLetters(_ indexes: [Int])
    func revealErrorLetters(_ indexes: [Int])
    
    func revealHeadDoll(_ imageBase64: String)
    func revealBodyDoll(_ imageBase64: String)
    func revealDollEndGameSuccess(_ imageBase64: String)
    func revealDollEndGameFailure(_ imageBase64: String)
}
