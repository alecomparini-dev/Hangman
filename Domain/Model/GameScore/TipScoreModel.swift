//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct TipScoreModel {
    public var freeTip: Int8
    public var adTip: Int8
 
    public init(freeTip: Int8, adTip: Int8) {
        self.freeTip = freeTip
        self.adTip = adTip
    }
}
