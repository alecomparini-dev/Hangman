//  Created by Alessandro Comparini on 17/01/24.
//

import Foundation

public protocol UseGameHelpUseCase {
    func use(_ userID: String, _ typeGameHelp: TypeGameHelp) async throws
}
