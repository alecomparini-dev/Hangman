//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain

public protocol HomePresenter {
    typealias UserID = String
    var delegateOutput: HomePresenterOutput? { get set }
    
    var dataTransfer: DataTransferDTO? { get set }
    
    var isEndGame: Bool { get }
    
    func startGame()
    
    func getLettersKeyboard() -> [String]
    
    func getNextWord()
        
    func getCurrentWord() -> WordPresenterDTO?
    
    func verifyMatchInWord(_ letter: String?)
        
    
}
