//  Created by Alessandro Comparini on 14/01/24.
//

import Foundation

public struct TypeGameHelpModel {
    public var lives: LivesGameHelpModel?
    public var hints: HintsGameHelpModel?
    public var revelations: RevelationsGameHelpModel?
    
    public init(lives: LivesGameHelpModel? = nil, hints: HintsGameHelpModel? = nil, revelations: RevelationsGameHelpModel? = nil) {
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
    
}
