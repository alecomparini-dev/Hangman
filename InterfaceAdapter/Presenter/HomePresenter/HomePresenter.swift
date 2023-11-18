//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

import Domain


public protocol HomePresenter {
    
    
    func getLettersKeyboard() -> [String]
    
    func fetchNextWords(_ lastPlayedWord: String, quantityWords: Int)
    
}
