//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain


class MaxGameHelpUseCaseSpy: MaxGameHelpUseCase {
    var typeGameHelp:TypeGameHelp = .hints
    
    func max(typeGameHelp: TypeGameHelp) -> Int {
        self.typeGameHelp = typeGameHelp
        let result:[TypeGameHelp: Int] = [.lives:5, .hints: 10, .revelations: 5]
        return result[typeGameHelp] ?? 0
    }
    
}
