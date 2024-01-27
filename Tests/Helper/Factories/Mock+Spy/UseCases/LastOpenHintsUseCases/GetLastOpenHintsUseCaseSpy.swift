//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class GetLastOpenHintsUseCaseSpy: GetLastOpenHintsUseCase {
    var userID = ""
    
    var result: Result<[Int], Error> = .success([])
    
    func get(_ userID: String) async throws -> [Int] {
        self.userID = userID
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
}
