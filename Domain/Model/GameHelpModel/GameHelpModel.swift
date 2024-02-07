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



//  MARK: - EQUATABLE

extension GameHelpModel: Equatable {
    public static func == (lhs: GameHelpModel, rhs: GameHelpModel) -> Bool {
        return lhs.dateRenewFree == rhs.dateRenewFree &&
        lhs.typeGameHelp?.hints == rhs.typeGameHelp?.hints &&
        lhs.typeGameHelp?.lives == rhs.typeGameHelp?.lives &&
        lhs.typeGameHelp?.revelations == rhs.typeGameHelp?.revelations
    }
}
