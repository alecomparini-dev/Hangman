//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public class GetLastOpenHintsUseCaseImpl: GetLastOpenHintsUseCase {

    private let getLastOpenHintsGateway: GetLastOpenHintsUseCaseGateway
    
    public init(getLastOpenHintsGateway: GetLastOpenHintsUseCaseGateway) {
        self.getLastOpenHintsGateway = getLastOpenHintsGateway
    }

    public func get(_ userID: String) async throws -> [Index] {
        return try await getLastOpenHintsGateway.get(userID)
    }
    
    
}
