//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import Domain


public class DataStorageFetchAtIDNexWordsUseCaseGatewayImpl: GetNextWordsUseCaseGateway {
    
    private let fetchAtIDDataStorage: FetchAtIDDataStorageProvider
    
    public init(fetchAtIDDataStorage: FetchAtIDDataStorageProvider) {
        self.fetchAtIDDataStorage = fetchAtIDDataStorage
    }
    
    
    public func nextWords(atID: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO] {
        
        var fetchWords: [[String: Any]]?
        
        if let limit {
            fetchWords = try await fetchAtIDDataStorage.fetchAt(id: atID, limit: limit)
        } else {
            fetchWords = try await fetchAtIDDataStorage.fetchAt(id: atID)
        }
        
        guard let fetchWords else {return []}
        
        return fetchWords.map {
            return GetNextWordsUseCaseDTO(
                id: $0["id"] as? Int,
                word: $0["word"] as? String,
                syllables: $0["syllables"] as? [String],
                category: $0["category"] as? String,
                initialTip: $0["initialTip"] as? String,
                level: $0["level"] as? Int,
                tips: $0["tips"] as? [String]
            )
        }
        
    }
    
    
}