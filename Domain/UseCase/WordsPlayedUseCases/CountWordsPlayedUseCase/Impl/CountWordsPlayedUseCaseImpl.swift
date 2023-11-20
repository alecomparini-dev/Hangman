//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public class CountWordsPlayedUseCaseImpl: CountWordsPlayedUseCase {
    
    private let countWordsPlayedGateway: CountWordsPlayedUseCaseGateway
    
    public init(countWordsPlayedGateway: CountWordsPlayedUseCaseGateway) {
        self.countWordsPlayedGateway = countWordsPlayedGateway
    }
    
    public func count(userID: String) async throws -> Int {
        return try await countWordsPlayedGateway.count(userID: userID)
    }
    
}
