//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpPresenterDTO {
    public var lives: Int8
    public var hints: Int8
    public var revelations: Int8
    
    public init(lives: Int8, hints: Int8, revelations: Int8) {
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
}
