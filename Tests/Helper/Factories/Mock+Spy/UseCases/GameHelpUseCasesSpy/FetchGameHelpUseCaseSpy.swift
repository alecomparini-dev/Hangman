//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class FetchGameHelpUseCaseSpy: FetchGameHelpUseCase {
    var userID = ""
    
    var result: Result<FetchGameHelpUseCaseDTO?, Error> = .success(nil)
    
    func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO? {
        self.userID = userID
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
}
