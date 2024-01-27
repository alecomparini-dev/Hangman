//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation
import Presenter

class HomePresenterOutputMock: HomePresenterOutput {
    
    var isMainThread = false
    
    func successFetchNextWord(word: WordPresenterDTO?) {
        verifyMainThread()
    }
    
    func nextWordIsOver(title: String, message: String) {
        verifyMainThread()
    }
    
    func errorFetchNextWords(title: String, message: String) {
        verifyMainThread()
    }
    
    func fetchGameHelpSuccess(_ gameHelp: GameHelpPresenterDTO) {
        verifyMainThread()
    }
    
    func updateLivesCount(_ count: String) {
        verifyMainThread()
    }
    
    func updateHintsCount(_ count: String) {
        verifyMainThread()
    }
    
    func updateRevelationsCount(_ count: String) {
        verifyMainThread()
    }
    
    func updateCountCorrectLetters(_ count: String) {
        verifyMainThread()
    }
    
    func markChosenKeyboardLetter(isCorrect: Bool, _ keyboardLetter: String) {
        verifyMainThread()
    }
    
    func revealCorrectLetters(_ indexes: [Int]) {
        verifyMainThread()
    }
    
    func revealErrorLetters(_ indexes: [Int]) {
        verifyMainThread()
    }
    
    func revealHeadDoll(_ imageBase64: String) {
        verifyMainThread()
    }
    
    func revealBodyDoll(_ imageBase64: String) {
        verifyMainThread()
    }
    
    func revealDollEndGameSuccess(_ imageBase64: String) {
        verifyMainThread()
    }
    
    func revealDollEndGameFailure(_ imageBase64: String) {
        verifyMainThread()
    }
    
    
    private func verifyMainThread() {
        if Thread.isMainThread {
            isMainThread = true
        }
    }
    
}
