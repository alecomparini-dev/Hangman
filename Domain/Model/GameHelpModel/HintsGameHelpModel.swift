//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct HintsGameHelpModel {
    public var freeHints: Int8
    public var adHints: Int8
 
    public init(freeHints: Int8, adHints: Int8) {
        self.freeHints = freeHints
        self.adHints = adHints
    }
}
