//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct RevelationsGameHelpModel {
    public var freeRevelations: Int
    public var buyRevelations: Int
    public var adRevelations: Int
    
    public init(freeRevelations: Int, buyRevelations: Int, adRevelations: Int) {
        self.freeRevelations = freeRevelations
        self.buyRevelations = buyRevelations
        self.adRevelations = adRevelations
    }
    
}
