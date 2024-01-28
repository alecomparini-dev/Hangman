//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class DeleteLastOpenHintsUseCaseSpy: DeleteLastOpenHintsUseCase {
    var userID = ""
    var result: Result<Bool?, Error> = .success(nil)
    
    func delete(_ userID: String) async throws {
        self.userID = userID
        
        switch result {
            case .success:
                return
            case .failure(let error):
                throw error
        }
    }
    
}
