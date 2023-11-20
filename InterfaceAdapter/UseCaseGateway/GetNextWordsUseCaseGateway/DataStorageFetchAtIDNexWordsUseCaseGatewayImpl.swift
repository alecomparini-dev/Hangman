//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import Domain


public class DataStorageFetchAtIDNexWordsUseCaseGatewayImpl: GetNextWordsUseCaseGateway {
    
    private let fetchAtIDDataStorage: FetchAtDataStorageProvider
    
    public init(fetchAtIDDataStorage: FetchAtDataStorageProvider) {
        self.fetchAtIDDataStorage = fetchAtIDDataStorage
    }
    
    
    public func nextWords(atID: Int, limit: Int?) async throws -> [NextWordsUseCaseDTO] {
        
        var fetchWords: [[String: Any]]?
        
        if let limit {
            fetchWords = try await fetchAtIDDataStorage.fetchAt(id: atID, limit: limit)
        } else {
            fetchWords = try await fetchAtIDDataStorage.fetchAt(id: atID)
        }
        
        guard let fetchWords else {return []}
        
        return fetchWords.map {
            return NextWordsUseCaseDTO(
                id: $0["id"] as? Int ?? 0,
                word: $0["word"] as? String,
                syllables: $0["syllables"] as? [String],
                category: $0["category"] as? String,
                initialTip: $0["initialTip"] as? String,
                level: $0["level"] as? Level,
                tips: $0["tips"] as? [String]
            )
        }
        
    }
    
    
}
