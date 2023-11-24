//  Created by Alessandro Comparini on 24/11/23.
//

import Foundation
import Domain

public struct DataTransferDTO {
    public var userID: String
    public var wordPlaying: NextWordsUseCaseDTO
    public var nextWords: [NextWordsUseCaseDTO]?
    
    public init(userID: String, wordPlaying: NextWordsUseCaseDTO, nextWords: [NextWordsUseCaseDTO]?) {
        self.userID = userID
        self.wordPlaying = wordPlaying
        self.nextWords = nextWords
    }
}
