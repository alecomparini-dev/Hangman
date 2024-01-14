//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct LivesGameHelpModel {
    public var freeLives: Int
    public var buyLives: Int
    public var adLives: Int
    
    public init(freeLives: Int, buyLives: Int, adLives: Int) {
        self.freeLives = freeLives
        self.buyLives = buyLives
        self.adLives = adLives
    }
}
