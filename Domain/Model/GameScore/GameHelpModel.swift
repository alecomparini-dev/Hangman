//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpModel {
    public var dateRenew: Date?
    public var lives: GameHelpLivesModel?
    public var tips: GameHelpTipsModel?
    public var revelations: GameHelpRevelationsModel?
    
    public init(dateRenew: Date? = nil, lives: GameHelpLivesModel? = nil, tips: GameHelpTipsModel? = nil, revelations: GameHelpRevelationsModel? = nil) {
        self.dateRenew = dateRenew
        self.lives = lives
        self.tips = tips
        self.revelations = revelations
    }
    
}
