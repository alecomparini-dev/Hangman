//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain

public enum TypeGameHelp {
    case lives
    case hints
    case revelations
}

public protocol HomePresenter {
    typealias UserID = String
    
    var delegateOutput: HomePresenterOutput? { get set }
    
    var dataTransfer: DataTransferHomeVC? { get set }
    
    var isEndGame: Bool { get }
    
    var gameHelpPresenter: GameHelpPresenterDTO? { get }

    func startGame()

    func getLettersKeyboard() -> [String]
    
    func getNextWord()
        
    func getCurrentWord() -> WordPresenterDTO?
        
    func verifyMatchInWord(_ letter: String?)
    
    func revealLetterGameRandom(_ duration: CGFloat)
    
    func maxHelp(_ typeGameHelp: TypeGameHelp) -> Int
    
}
