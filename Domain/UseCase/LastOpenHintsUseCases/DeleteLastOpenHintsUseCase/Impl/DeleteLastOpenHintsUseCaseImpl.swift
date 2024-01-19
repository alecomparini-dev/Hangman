//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public class DeleteLastOpenHintsUseCaseImpl: DeleteLastOpenHintsUseCase {

    private let updateLastOpenHintsGateway: UpdateLastOpenHintsUseCaseGateway
    
    public init(updateLastOpenHintsGateway: UpdateLastOpenHintsUseCaseGateway) {
        self.updateLastOpenHintsGateway = updateLastOpenHintsGateway
    }

    public func delete(_ userID: String) async throws {
        try await updateLastOpenHintsGateway.update(userID, [])
    }
    
}
