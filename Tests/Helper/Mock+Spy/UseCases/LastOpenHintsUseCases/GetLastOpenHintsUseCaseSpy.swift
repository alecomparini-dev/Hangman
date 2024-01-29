//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class GetLastOpenHintsUseCaseSpy: ObservableResultSpy, GetLastOpenHintsUseCase {
    var userID = ""
    
    func get(_ userID: String) async throws -> [Int] {
        self.userID = userID
        return try await result() ?? []
    }
    
}
