//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class GetDollsRandomUseCaseSpy: GetDollsRandomUseCase {
    var quantity = 0
    
    var result: Result<[DollUseCaseDTO], Error> = .success([])
    
    func getDollsRandom(quantity: Int) async throws -> [DollUseCaseDTO] {
        self.quantity = quantity
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
        
}
