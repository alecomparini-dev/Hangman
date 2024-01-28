//  Created by Alessandro Comparini on 26/01/24.
//

import Foundation
import Domain
import Presenter

struct DataTransferHomeVCFactory {
    
    func make(userID: String = "123",
              wordPlaying: NextWordsUseCaseDTO? = nil,
              nextWords: [NextWordsUseCaseDTO]? = nil,
              dolls: [DollUseCaseDTO]? = nil,
              gameHelpPresenterDTO: GameHelpPresenterDTO? = nil) -> DataTransferHomeVC? {
        
        return DataTransferHomeVC(userID: userID,
                                  wordPlaying: wordPlaying,
                                  nextWords: nextWords,
                                  dolls: dolls,
                                  gameHelpPresenterDTO: gameHelpPresenterDTO)
    }
    
}
