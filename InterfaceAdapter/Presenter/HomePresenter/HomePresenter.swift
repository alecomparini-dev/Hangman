//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain


public protocol HomePresenter {
    typealias UserID = String
    var delegateOutput: ProfileSummaryPresenterOutput? { get set }
    
    func startGame()
    
    func getLettersKeyboard() -> [String]
    
    func getNextWord()
        
    func getCurrentWord() -> NextWordPresenterDTO?
    
    
    func verifyMatchInWord(_ char: String?)
    
    func resetGame()
}
