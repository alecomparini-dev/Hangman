//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class CountDollsUseCaseMock: CountDollsUseCase {
    
    var result: Result<Int, Error> = .success(1)
    
    func count() async throws -> Int {
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
        
}
