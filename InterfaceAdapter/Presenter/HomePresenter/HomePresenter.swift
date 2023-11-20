//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain


public protocol HomePresenter {
    var delegateOutput: ProfileSummaryPresenterOutput? { get set }
    
    func getLettersKeyboard() -> [String]
    
    func signInAnonymously()
    
    func fetchNextWord()
    
    func countWordsPlayed()
}
