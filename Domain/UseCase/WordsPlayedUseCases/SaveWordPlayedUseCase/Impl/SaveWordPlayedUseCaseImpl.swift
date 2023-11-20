//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public class SaveWordPlayedUseCaseImpl: SaveWordPlayedUseCase {
    
    private let saveWordPlayedGateway: SaveWordPlayedUseCaseGateway
    
    public init(saveWordPlayedGateway: SaveWordPlayedUseCaseGateway) {
        self.saveWordPlayedGateway = saveWordPlayedGateway
    }
    
    
    public func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws {
        try await saveWordPlayedGateway.save(userID: userID, wordPlayed)
    }
    
    
}
