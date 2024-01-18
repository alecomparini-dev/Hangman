//  Created by Alessandro Comparini on 10/01/24.
//

import Foundation
import Domain

public struct DataTransferHints {
    public typealias closureUpdateHintsAlias = (_ count: Int) -> Void
    
    public var userID: String?
    public var wordPresenterDTO: WordPresenterDTO?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    public var delegate: HintsPresenterOutput
    
    public init(userID: String? = nil, wordPresenterDTO: WordPresenterDTO? = nil, gameHelpPresenterDTO: GameHelpPresenterDTO? = nil, delegate: HintsPresenterOutput) {
        self.userID = userID
        self.wordPresenterDTO = wordPresenterDTO
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
        self.delegate = delegate
    }
    
}
