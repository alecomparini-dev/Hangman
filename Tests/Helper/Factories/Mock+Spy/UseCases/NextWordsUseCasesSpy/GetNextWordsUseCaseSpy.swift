//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class GetNextWordsUseCaseSpy: ObservableResultSpy, GetNextWordsUseCase {
    var atID = 0
    var limit: Int?
    
    func nextWords(atID: Int, limit: Int?) async throws -> [NextWordsUseCaseDTO] {
        self.atID = atID
        self.limit = limit
        return try await result() ?? []
    }
        
    
}
