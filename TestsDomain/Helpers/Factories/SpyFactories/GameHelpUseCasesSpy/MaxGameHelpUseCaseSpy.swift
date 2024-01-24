//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain


class MaxGameHelpUseCaseSpy: MaxGameHelpUseCase {
    var typeGameHelp:TypeGameHelp = .hints
    var result: Int!
    
    func max(typeGameHelp: TypeGameHelp) -> Int {
        self.typeGameHelp = typeGameHelp
        return result
    }
    
}
