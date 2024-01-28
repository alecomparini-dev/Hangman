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
        isMainThread = false
        if Thread.isMainThread {
            isMainThread = true
        }
    }
    
}
