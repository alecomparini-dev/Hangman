//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation
import Presenter

class HomePresenterOutputMock: ObservableResultSpy, HomePresenterOutput {
    
    override init() {
        super.init()
    }
    
    var isMainThread = false
    
    func fetchNextWordSuccess(word: WordPresenterDTO?) {
        verifyMainThread()
        if let word {
            sendOutput(word)
        }
    }
    
    func nextWordIsOver(title: String, message: String) {
        verifyMainThread()
        sendOutput([title, message])
    }
    
    func errorFetchNextWords(title: String, message: String) {
        verifyMainThread()
    }
    
    func fetchGameHelpSuccess(_ gameHelp: GameHelpPresenterDTO) {
        verifyMainThread()
        sendOutput(gameHelp)
    }
    
    func updateLivesCount(_ count: String) {
        verifyMainThread()
        sendOutput(["updateLivesCount": count])
    }
    
    func updateRevelationsCount(_ count: String) {
        verifyMainThread()
    }
    
    func updateCountCorrectLetters(_ count: String) {
        verifyMainThread()
        sendOutput(["updateCountCorrectLetters": count])
    }
    
    func markChosenKeyboardLetter(isCorrect: Bool, _ keyboardLetter: String) {
        verifyMainThread()
        sendOutput(["markChosenKeyboardLetter": [isCorrect, keyboardLetter]])
    }
    
    func revealCorrectLetters(_ indexes: [Int]) {
        verifyMainThread()
        sendOutput(["revealCorrectLetters": indexes])
    }
    
    func revealErrorLetters(_ indexes: [Int]) {
        verifyMainThread()
        sendOutput(["revealErrorLetters": indexes])
    }
    
    func revealHeadDoll(_ imageBase64: String) {
        verifyMainThread()
        sendOutput(["revealHeadDoll": imageBase64])
    }
    
    func revealBodyDoll(_ imageBase64: String) {
        verifyMainThread()
        sendOutput(["revealBodyDoll": imageBase64])
    }
    
    func revealDollEndGameSuccess(_ imageBase64: String) {
        verifyMainThread()
    }
    
    func revealDollEndGameFailure(_ imageBase64: String) {
        verifyMainThread()
        sendOutput(["revealDollEndGameFailure": imageBase64])
    }
    
    
    private func verifyMainThread() {
        isMainThread = false
        if Thread.isMainThread {
            isMainThread = true
        }
    }
    
}
