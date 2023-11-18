//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public class GetNextWordsUseCaseImpl: GetNextWordsUseCase {
    
    private let nextWordsGateway: GetNextWordsUseCaseGateway
    
    public init(nextWordsGateway: GetNextWordsUseCaseGateway) {
        self.nextWordsGateway = nextWordsGateway
    }
    
    
    public func nextWords(at: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO] {
        return try await nextWordsGateway.nextWords(at: at, limit: limit)
    }
    
    
}
