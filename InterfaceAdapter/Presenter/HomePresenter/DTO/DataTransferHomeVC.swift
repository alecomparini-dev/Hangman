//  Created by Alessandro Comparini on 24/11/23.
//

import Foundation
import Domain

public struct DataTransferHomeVC {
    public var userID: String
    public var wordPlaying: NextWordsUseCaseDTO?
    public var nextWords: [NextWordsUseCaseDTO]?
    public var dolls: [DollUseCaseDTO]?
    public var gameHelpPresenterDTO: GameHelpPresenterDTO?
    
    public init(userID: String, wordPlaying: NextWordsUseCaseDTO? = nil, nextWords: [NextWordsUseCaseDTO]? = nil, dolls: [DollUseCaseDTO]? = nil, gameHelpPresenterDTO: GameHelpPresenterDTO? = nil) {
        self.userID = userID
        self.wordPlaying = wordPlaying
        self.nextWords = nextWords
        self.dolls = dolls
        self.gameHelpPresenterDTO = gameHelpPresenterDTO
    }
    
}

//  MARK: - EXTENSION - EQUATABLE
extension DataTransferHomeVC: Equatable {
    
    public static func == (lhs: DataTransferHomeVC, rhs: DataTransferHomeVC) -> Bool {
        return lhs.userID == rhs.userID &&
        lhs.gameHelpPresenterDTO?.hintsCount == rhs.gameHelpPresenterDTO?.hintsCount &&
        lhs.gameHelpPresenterDTO?.revelationsCount == rhs.gameHelpPresenterDTO?.revelationsCount &&
        lhs.gameHelpPresenterDTO?.livesCount == rhs.gameHelpPresenterDTO?.livesCount &&
        
        (lhs.dolls != nil) == (rhs.dolls != nil) &&
        
        (lhs.nextWords != nil) == (rhs.nextWords != nil) &&
        
        lhs.wordPlaying?.id == rhs.wordPlaying?.id &&
        lhs.wordPlaying?.word == rhs.wordPlaying?.word &&
        lhs.wordPlaying?.category == rhs.wordPlaying?.category &&
        lhs.wordPlaying?.initialQuestion == rhs.wordPlaying?.initialQuestion &&
        lhs.wordPlaying?.syllables == rhs.wordPlaying?.syllables &&
        lhs.wordPlaying?.hints == rhs.wordPlaying?.hints &&
        lhs.wordPlaying?.level == rhs.wordPlaying?.level
    }
    
}
