//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpLivesModel {
    public var freeLives: Int8
    public var buyLives: Int8
    public var adLives: Int8
    
    public init(freeLives: Int8, buyLives: Int8, adLives: Int8) {
        self.freeLives = freeLives
        self.buyLives = buyLives
        self.adLives = adLives
    }
}
