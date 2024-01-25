//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public class GetDollsRandomUseCaseImpl: GetDollsRandomUseCase {
    
    private let countDollsUseCase: CountDollsUseCase
    private let getDollsGateway: GetDollsUseCaseGateway
    
    public init(countDollsUseCase: CountDollsUseCase, getDollsGateway: GetDollsUseCaseGateway) {
        self.countDollsUseCase = countDollsUseCase
        self.getDollsGateway = getDollsGateway
    }
    
    public func getDollsRandom(quantity: Int) async throws -> [DollUseCaseDTO] {
        let countDolls = try await countDollsUseCase.count()
        let ids: [Int] = makeRandomIDs(quantity, countDolls)
        return try await getDollsGateway.getDolls(id: ids)
    }
    
    
//  MARK: - PRIVATE AREA
    private func makeRandomIDs(_ quantity: Int = 1, _ countDolls: Int) -> [Int] {
        var setIds = Set<Int>()
        
        if quantity >= countDolls {
            return Array(1...countDolls)
        }
        
        _ = (1...quantity).map({ _ in
            setIds.insert(Int.random(in: 1...countDolls))
        })
        
        return Array(setIds)
    }
    
}
