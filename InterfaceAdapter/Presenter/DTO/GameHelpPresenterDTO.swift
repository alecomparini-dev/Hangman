//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpPresenterDTO {
    public var lives: Int
    public var hints: Int
    public var revelations: Int
    
    public init(lives: Int, hints: Int, revelations: Int) {
        self.lives = lives
        self.hints = hints
        self.revelations = revelations
    }
}
