//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct RevealLetterScoreModel {
    public var freeReveal: Int8
    public var buyReveal: Int8
    public var adReveal: Int8
    
    public init(freeReveal: Int8, buyReveal: Int8, adReveal: Int8) {
        self.freeReveal = freeReveal
        self.buyReveal = buyReveal
        self.adReveal = adReveal
    }
    
}
