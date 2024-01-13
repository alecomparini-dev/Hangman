//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpModel {
    public var dateRenew: Date?
    public var lives: LivesGameHelpModel?
    public var hints: HintsGameHelpModel?
    public var revelations: RevelationsGameHelpModel?
    
    public init(dateRenew: Date? = nil, lives: LivesGameHelpModel? = nil, hints: HintsGameHelpModel? = nil, revelations: RevelationsGameHelpModel? = nil) {
        self.dateRenew = dateRenew
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
    
}
