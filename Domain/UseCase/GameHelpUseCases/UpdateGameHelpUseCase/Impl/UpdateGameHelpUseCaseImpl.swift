//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation

public class UpdateGameHelpUseCaseImpl: UpdateGameHelpUseCase {
    
    private let updateGameGateway: UpdateGameHelpUseCaseGateway
    
    public init(updateGameGateway: UpdateGameHelpUseCaseGateway) {
        self.updateGameGateway = updateGameGateway
    }
    
    public func update(_ userID: String, gameHelp: GameHelpModel) async throws {
        try await updateGameGateway.update(userID, gameHelp: gameHelp)
    }
    
}
