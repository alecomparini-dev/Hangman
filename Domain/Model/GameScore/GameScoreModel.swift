//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameScoreModel {
    public var lifeScore: LifeScoreModel?
    public var tipScore: TipScoreModel?
    public var revealLetterScore: RevealLetterScoreModel?
    
    public init(lifeScore: LifeScoreModel? = nil, tipScore: TipScoreModel? = nil, revealLetterScore: RevealLetterScoreModel? = nil) {
        self.lifeScore = lifeScore
        self.tipScore = tipScore
        self.revealLetterScore = revealLetterScore
    }
}
