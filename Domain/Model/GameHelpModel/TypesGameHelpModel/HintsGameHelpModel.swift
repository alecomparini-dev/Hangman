//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct HintsGameHelpModel {
    public var freeHints: Int
    public var adHints: Int
 
    public init(freeHints: Int, adHints: Int) {
        self.freeHints = freeHints
        self.adHints = adHints
    }
}
