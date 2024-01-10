//  Created by Alessandro Comparini on 10/01/24.
//

import Foundation
import Domain

public struct DataTransferTipsVC {
    public typealias closureUpdateTipAlias = (_ count: String) -> Void
    
    public var wordPresenterDTO: WordPresenterDTO?
    public var gameScore: GameScoreModel?
    public var updateTipCompletion: closureUpdateTipAlias?
    
    public init(wordPresenterDTO: WordPresenterDTO? = nil, gameScore: GameScoreModel? = nil, updateTipCompletion: closureUpdateTipAlias? = nil) {
        self.wordPresenterDTO = wordPresenterDTO
        self.gameScore = gameScore
        self.updateTipCompletion = updateTipCompletion
    }
    
}
