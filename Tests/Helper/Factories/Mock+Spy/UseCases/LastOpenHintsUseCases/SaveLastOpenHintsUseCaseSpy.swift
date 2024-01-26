//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import Domain

class SaveLastOpenHintsUseCaseSpy: SaveLastOpenHintsUseCase {
    var userID = ""
    var indexes: [Int]!
    var result: Result<Bool?, Error> = .success(true)
    
    func save(_ userID: String, _ indexes: [Int]) async throws {
        self.userID = userID
        self.indexes = indexes
        
        switch result {
            case .success:
                return
            case .failure(let error):
                throw error
        }
    }
    
    
}
