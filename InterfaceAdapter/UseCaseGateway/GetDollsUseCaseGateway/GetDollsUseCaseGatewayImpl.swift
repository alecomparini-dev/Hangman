//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation
import Domain


public class GetDollsUseCaseGatewayImpl: GetDollsUseCaseGateway {
    
    private let fetchInDataStorage: FetchInDataStorageProvider
    
    public init(fetchInDataStorage: FetchInDataStorageProvider) {
        self.fetchInDataStorage = fetchInDataStorage
    }
    
    public func getDolls(id: [Int]) async throws -> [DollUseCaseDTO] {
        let dolls: [Dictionary<String,Any>]? = try await fetchInDataStorage.fetchIn(id: id)
        
        let dollUseCaseDTO: [DollUseCaseDTO]? = MapperDictDollsToListDollUseCaseDTO().mapper(dolls)
        
        guard let dollUseCaseDTO else { return [] }
        
        return dollUseCaseDTO
    }
    
    
}
