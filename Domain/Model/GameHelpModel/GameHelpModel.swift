//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpModel {
    public var dateRenewFree: Date?
    public var typeGameHelp: TypeGameHelpModel?
    
    public init(dateRenewFree: Date? = nil, typeGameHelp: TypeGameHelpModel? = nil) {
        self.dateRenewFree = dateRenewFree
        self.typeGameHelp = typeGameHelp
    }
    
}
