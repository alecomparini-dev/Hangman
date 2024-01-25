//
//  CountDollsUseCaseSpy.swift
//  TestsDomain
//
//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class GetDollsUseCaseGatewaySpy: GetDollsUseCaseGateway {
    var id: [Int] = []
    var result: Result<[DollUseCaseDTO], Error> = .success([])
    
    func getDolls(id: [Int]) async throws -> [DollUseCaseDTO] {
        self.id = id
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
    
}
