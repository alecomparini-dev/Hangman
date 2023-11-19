//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public class GetNextWordsUseCaseImpl: GetNextWordsUseCase {
    
    private let nextWordsGateway: GetNextWordsUseCaseGateway
    
    public init(nextWordsGateway: GetNextWordsUseCaseGateway) {
        self.nextWordsGateway = nextWordsGateway
    }
    
    
    public func nextWords(atID: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO] {
        return try await nextWordsGateway.nextWords(atID: atID, limit: limit)
    }
    
    
}
