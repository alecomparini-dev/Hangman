//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation

public protocol UpdateGameHelpUseCaseGateway {
    func update(_ userID: String, gameHelp: GameHelpModel) async throws
}
