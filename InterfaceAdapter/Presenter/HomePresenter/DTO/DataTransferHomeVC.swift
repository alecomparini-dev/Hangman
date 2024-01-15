//  Created by Alessandro Comparini on 24/11/23.
//

import Foundation
import Domain

public struct DataTransferHomeVC {
    public var userID: String
    public var wordPlaying: NextWordsUseCaseDTO
    public var nextWords: [NextWordsUseCaseDTO]?
    public var dolls: [DollUseCaseDTO]?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    
    public init(userID: String, wordPlaying: NextWordsUseCaseDTO, nextWords: [NextWordsUseCaseDTO]? = nil, dolls: [DollUseCaseDTO]? = nil, gameHelpPresenterDTO: GameHelpPresenterDTO? = nil) {
        self.userID = userID
        self.wordPlaying = wordPlaying
        self.nextWords = nextWords
        self.dolls = dolls
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
    }
    
}
