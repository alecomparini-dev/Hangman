//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation
import Presenter

class HomePresenterOutputSpy: ObservableResultSpy, HomePresenterOutput {
    var called =  Called()
    struct Called {
        var fetchNextWordSuccess = false
        var nextWordIsOver = false
        var errorFetchNextWords = false
        var fetchGameHelpSuccess = false
        var updateLivesCount = false
        var updateRevelationsCount = false
        var updateCountCorrectLetters = false
        var markChosenKeyboardLetter = false
        var revealCorrectLetters = false
        var revealErrorLetters = false
        var revealHeadDoll = false
        var revealBodyDoll = false
        var revealDollEndGameSuccess = false
        var revealDollEndGameFailure = false
    }
    
    override init() {
        super.init()
    }
    
    var isMainThread = false
    
    func fetchNextWordSuccess(word: WordPresenterDTO?) {
        called.fetchNextWordSuccess = true
        verifyMainThread()
        if let word {
            sendOutput(word)
        }
    }
    
    func nextWordIsOver(title: String, message: String) {
        called.nextWordIsOver = true
        verifyMainThread()
        sendOutput([title, message])
    }
    
    func errorFetchNextWords(title: String, message: String) {
        called.errorFetchNextWords = true
        verifyMainThread()
    }
    
    func fetchGameHelpSuccess(_ gameHelp: GameHelpPresenterDTO) {
        called.fetchGameHelpSuccess = true
        verifyMainThread()
        sendOutput(gameHelp)
    }
    
    func updateLivesCount(_ count: String) {
        called.updateLivesCount = true
        verifyMainThread()
        sendOutput(["updateLivesCount": count])
    }
    
    func updateRevelationsCount(_ count: String) {
        called.updateRevelationsCount = true
        verifyMainThread()
        sendOutput(["updateRevelationsCount": count])
    }
    
    func updateCountCorrectLetters(_ count: String) {
        called.updateCountCorrectLetters = true
        verifyMainThread()
        sendOutput(["updateCountCorrectLetters": count])
    }
    
    func markChosenKeyboardLetter(isCorrect: Bool, _ keyboardLetter: String) {
        called.markChosenKeyboardLetter = true
        verifyMainThread()
        sendOutput(["markChosenKeyboardLetter": [isCorrect, keyboardLetter]])
    }
    
    func revealCorrectLetters(_ indexes: [Int]) {
        called.revealCorrectLetters = true
        verifyMainThread()
        sendOutput(["revealCorrectLetters": indexes])
    }
    
    func revealErrorLetters(_ indexes: [Int]) {
        called.revealErrorLetters = true
        verifyMainThread()
        sendOutput(["revealErrorLetters": indexes])
    }
    
    func revealHeadDoll(_ imageBase64: String) {
        called.revealHeadDoll = true
        verifyMainThread()
        sendOutput(["revealHeadDoll": imageBase64])
    }
    
    func revealBodyDoll(_ imageBase64: String) {
        called.revealBodyDoll = true
        verifyMainThread()
        sendOutput(["revealBodyDoll": imageBase64])
    }
    
    func revealDollEndGameSuccess(_ imageBase64: String) {
        called.revealDollEndGameSuccess = true
        verifyMainThread()
        sendOutput(["revealDollEndGameSuccess": imageBase64])
    }
    
    func revealDollEndGameFailure(_ imageBase64: String) {
        called.revealDollEndGameFailure = true
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
