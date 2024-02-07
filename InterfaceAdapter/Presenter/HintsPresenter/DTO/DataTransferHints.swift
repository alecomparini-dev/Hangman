//  Created by Alessandro Comparini on 10/01/24.
//

import Foundation
import Domain

public struct DataTransferHints {
    public typealias closureUpdateHintsAlias = (_ count: Int) -> Void
    
    public var userID: String?
    public var lastHintsOpen: [Int]?
    public var wordPresenterDTO: WordPresenterDTO?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    public var delegate: HintsPresenterOutput?
    
    public init(userID: String? = nil, 
                lastHintsOpen: [Int]? = nil,
                wordPresenterDTO: WordPresenterDTO? = nil,
                gameHelpPresenterDTO: GameHelpPresenterDTO? = nil,
                delegate: HintsPresenterOutput? = nil) {
        self.userID = userID
        self.lastHintsOpen = lastHintsOpen
        self.wordPresenterDTO = wordPresenterDTO
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
        self.delegate = delegate
    }
}
