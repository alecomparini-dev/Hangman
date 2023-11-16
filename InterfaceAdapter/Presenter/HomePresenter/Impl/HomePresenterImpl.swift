//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation

public class HomePresenterImpl: HomePresenter {
    
    public init() {}
    
    
    
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H",
                "I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X",
                "Y","Z",""]
    }
    
    
    public func fetchNextWords(_ lastPlayedWord: String, quantityWords: Int = 20) -> [String] {
        
        return []
    }
    
    
}
