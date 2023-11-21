//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain


public protocol HomePresenter {
    typealias UserID = String
    var delegateOutput: ProfileSummaryPresenterOutput? { get set }
    
    func getLettersKeyboard() -> [String]
    
    func getNextWord()
    
    func countWordsPlayed() async
    
    func getCurrentWord() -> NextWordPresenterDTO?
}
