//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class SaveWordPlayedUseCaseSpy: SaveWordPlayedUseCase {
    var userID = ""
    var wordPlayed: WordPlayedUseCaseDTO!
    
    var result: Result<Int, Error> = .success(0)
    
    func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws {
        self.userID = userID
        self.wordPlayed = wordPlayed
        
        switch result {
            case .success:
                return
            case .failure(let error):
                throw error
        }
    }
    
}
