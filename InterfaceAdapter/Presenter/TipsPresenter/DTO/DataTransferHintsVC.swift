//  Created by Alessandro Comparini on 10/01/24.
//

import Foundation
import Domain

public struct DataTransferHintsVC {
    public typealias closureUpdateHintsAlias = (_ count: String) -> Void
    
    public var wordPresenterDTO: WordPresenterDTO?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    public var updateHintsCompletion: closureUpdateHintsAlias?
    
    public init(wordPresenterDTO: WordPresenterDTO? = nil, 
                gameHelpPresenterDTO: GameHelpPresenterDTO? = nil,
                updateHintsCompletion: closureUpdateHintsAlias? = nil) {
        self.wordPresenterDTO = wordPresenterDTO
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
        self.updateHintsCompletion = updateHintsCompletion
    }
    
}
