//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain


public protocol HomePresenter {
    typealias UserID = String
    var delegateOutput: ProfileSummaryPresenterOutput? { get set }
    
    func getLettersKeyboard() -> [String]
    
    func signInAnonymously() async
    
    func getNextWord()
    
    func countWordsPlayed() async
    
    func saveWordPlayed() async
    
    func getCurrentWord() -> NextWordPresenterDTO?
}
