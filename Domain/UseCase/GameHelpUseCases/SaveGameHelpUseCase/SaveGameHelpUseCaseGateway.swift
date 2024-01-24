//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public protocol SaveGameHelpUseCaseGateway {
    func save(_ userID: String, gameHelp: GameHelpModel) async throws
}
