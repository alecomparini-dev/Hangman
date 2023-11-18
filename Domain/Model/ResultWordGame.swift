//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public struct ResultWordGame {
    public var success: Bool?
    public var correctWords: Int?
    public var wrongWords: Int?
    public var timeConclusion: Int?
    
    public init(success: Bool? = nil, correctWords: Int? = nil, wrongWords: Int? = nil) {
        self.success = success
        self.correctWords = correctWords
        self.wrongWords = wrongWords
    }
}
