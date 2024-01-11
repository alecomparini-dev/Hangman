//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpTipsModel {
    public var freeTips: Int8
    public var adTips: Int8
 
    public init(freeTips: Int8, adTips: Int8) {
        self.freeTips = freeTips
        self.adTips = adTips
    }
}
