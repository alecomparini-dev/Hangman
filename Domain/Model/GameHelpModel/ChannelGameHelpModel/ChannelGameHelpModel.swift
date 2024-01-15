//  Created by Alessandro Comparini on 14/01/24.
//

import Foundation

public struct ChannelGameHelpModel {
    public var free: Int?
    public var advertising: Int?
    public var buy: Int?
    
    public init(free: Int? = nil, advertising: Int? = nil, buy: Int? = nil) {
        self.free = free
        self.advertising = advertising
        self.buy = buy
    }
    
}
