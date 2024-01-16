//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation


protocol SaveGameHelpUseCase {
    func save(_ userID: String, gameHelp: GameHelpModel) async throws
}
