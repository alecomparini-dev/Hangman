//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpRevelationsModel {
    public var freeRevelations: Int8
    public var buyRevelations: Int8
    public var adRevelations: Int8
    
    public init(freeRevelations: Int8, buyRevelations: Int8, adRevelations: Int8) {
        self.freeRevelations = freeRevelations
        self.buyRevelations = buyRevelations
        self.adRevelations = adRevelations
    }
    
}
