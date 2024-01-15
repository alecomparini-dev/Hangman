//  Created by Alessandro Comparini on 15/01/24.
//

import Foundation

public class GetMaxTypeGameHelpUseCaseImpl: GetMaxTypeGameHelpUseCase {
    
    public init() {}
    
    public func max(typeGameHelp: TypeGameHelp) -> Int {
        return typeGameHelp.maxHelp()
    }
    
}
