//  Created by Alessandro Comparini on 10/01/24.
//

import Foundation
import Domain

public struct DataTransferHintsVC {
    public typealias closureUpdateTipAlias = (_ count: String) -> Void
    
    public var wordPresenterDTO: WordPresenterDTO?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    public var updateTipCompletion: closureUpdateTipAlias?
    
    public init(wordPresenterDTO: WordPresenterDTO? = nil, gameHelpPresenterDTO: GameHelpPresenterDTO? = nil, updateTipCompletion: closureUpdateTipAlias? = nil) {
        self.wordPresenterDTO = wordPresenterDTO
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
        self.updateTipCompletion = updateTipCompletion
    }
    
}
