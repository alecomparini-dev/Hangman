//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public struct WordPlayedPresenterDTO {
    public var wordID: Int
    public var success: Bool?
    public var correctWords: Int?
    public var wrongWords: Int?
    public var timeConclusion: Int?
    
    public init(wordID: Int, success: Bool? = nil, correctWords: Int? = nil, wrongWords: Int? = nil, timeConclusion: Int? = nil) {
        self.wordID = wordID
        self.success = success
        self.correctWords = correctWords
        self.wrongWords = wrongWords
        self.timeConclusion = timeConclusion
    }
    
}
