//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class FetchGameHelpUseCaseSpy: ObservableResultSpy, FetchGameHelpUseCase {
    var userID = ""
        
    func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO? {
        self.userID = userID
        return try await result()
    }
    
}
