//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpPresenterDTO {
    public var lives: Int8
    public var tips: Int8
    public var revelations: Int8
    
    public init(lives: Int8, tips: Int8, revelations: Int8) {
        self.lives = lives
        self.tips = tips
        self.revelations = revelations
    }
}
