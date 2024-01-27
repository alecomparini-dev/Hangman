//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import Domain

class GetDollsRandomUseCaseSpy<T>: ObservableResultSpy<T>, GetDollsRandomUseCase {
    var quantity = 0
    
    func getDollsRandom(quantity: Int) async throws -> [DollUseCaseDTO] {
        self.quantity = quantity
        return try await result() as? [DollUseCaseDTO] ?? []
    }
        
}
