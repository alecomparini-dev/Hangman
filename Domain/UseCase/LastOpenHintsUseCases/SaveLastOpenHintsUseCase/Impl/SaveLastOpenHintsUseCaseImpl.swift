//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public class SaveLastOpenHintsUseCaseImpl: SaveLastOpenHintsUseCase {
    
    private let saveLastOpenHintsUseCaseGateway: SaveLastOpenHintsUseCaseGateway
    
    public init(saveLastOpenHintsUseCaseGateway: SaveLastOpenHintsUseCaseGateway) {
        self.saveLastOpenHintsUseCaseGateway = saveLastOpenHintsUseCaseGateway
    }
    
    public func save(_ userID: String, _ indexes: [Int]) async throws {
        try await saveLastOpenHintsUseCaseGateway.save(userID, indexes)
    }
    
    
}
