//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public class SaveGameHelpUseCaseImpl: SaveGameHelpUseCase {
    
    private let saveGameHelpGateway: SaveGameHelpUseCaseGateway
    
    public init(saveGameHelpGateway: SaveGameHelpUseCaseGateway) {
        self.saveGameHelpGateway = saveGameHelpGateway
    }
    
    
    func save(_ userID: String, gameHelp: GameHelpModel) async throws {
        try await saveGameHelpGateway.save(userID, gameHelp: gameHelp)
    }
    
}
