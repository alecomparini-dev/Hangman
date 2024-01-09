//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct LifeScoreModel {
    public var freeLife: Int8
    public var buyLife: Int8
    public var adLife: Int8
    
    public init(freeLife: Int8, buyLife: Int8, adLife: Int8) {
        self.freeLife = freeLife
        self.buyLife = buyLife
        self.adLife = adLife
    }
}
