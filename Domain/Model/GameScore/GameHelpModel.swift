//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpModel {
    public var dateRenew: Date?
    public var lives: GameHelpLivesModel?
    public var hints: GameHelpHintsModel?
    public var revelations: GameHelpRevelationsModel?
    
    public init(dateRenew: Date? = nil, lives: GameHelpLivesModel? = nil, hints: GameHelpHintsModel? = nil, revelations: GameHelpRevelationsModel? = nil) {
        self.dateRenew = dateRenew
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
    
}
