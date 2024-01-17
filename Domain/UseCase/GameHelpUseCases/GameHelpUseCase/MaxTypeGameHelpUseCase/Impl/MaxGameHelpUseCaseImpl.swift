//  Created by Alessandro Comparini on 15/01/24.
//

import Foundation

public class MaxGameHelpUseCaseImpl: MaxGameHelpUseCase {
    
    public init() {}
    
    public func max(typeGameHelp: TypeGameHelp) -> Int {
        switch typeGameHelp {
        case .lives:
            return 5
        case .hints:
            return 10
        case .revelations:
            return 5
        }
    }
    
}
