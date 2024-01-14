//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpModel {
    public var dateRenewFree: Date?
    public var lives: LivesGameHelpModel?
    public var hints: HintsGameHelpModel?
    public var revelations: RevelationsGameHelpModel?
    
    public init(dateRenewFree: Date? = nil, lives: LivesGameHelpModel? = nil, hints: HintsGameHelpModel? = nil, revelations: RevelationsGameHelpModel? = nil) {
        self.dateRenewFree = dateRenewFree
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
    
}
