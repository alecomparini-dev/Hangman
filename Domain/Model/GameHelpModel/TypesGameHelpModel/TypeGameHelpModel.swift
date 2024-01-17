//  Created by Alessandro Comparini on 14/01/24.
//

import Foundation

public struct TypeGameHelpModel {
    public var lives: Int?
    public var hints: Int?
    public var revelations: Int?
    
    public init(lives: Int? = nil, hints: Int? = nil, revelations: Int? = nil) {
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
    
}
