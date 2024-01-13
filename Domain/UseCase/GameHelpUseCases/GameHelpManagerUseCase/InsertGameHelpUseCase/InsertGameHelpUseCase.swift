//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation


import Foundation

protocol InsertGameHelpUseCase {
    func insert(_ userID: String, gameHelp: GameHelpModel) async throws
}
