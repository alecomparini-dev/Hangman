//  Created by Alessandro Comparini on 26/01/24.
//

import Foundation
import Presenter

struct DataTransferHintsFactory {
    
    func make(userID: String? = "123", 
              lastHintsOpen: [Int]? = nil,
              wordPresenterDTO: WordPresenterDTO? = nil,
              gameHelpPresenterDTO: GameHelpPresenterDTO? = nil,
              delegate: HintsPresenterOutput? = nil) -> DataTransferHints? {
        
        return DataTransferHints(userID: userID,
                                 lastHintsOpen: lastHintsOpen,
                                 wordPresenterDTO: wordPresenterDTO,
                                 gameHelpPresenterDTO: gameHelpPresenterDTO,
                                 delegate: delegate)
    }
    
}
