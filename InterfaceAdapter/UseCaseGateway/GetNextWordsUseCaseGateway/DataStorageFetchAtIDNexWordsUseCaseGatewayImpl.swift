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
            var levelInsert: Level?
            
            if let level = $0["level"] as? Int {
                levelInsert = Level.init(rawValue: level)
            }
            
            return NextWordsUseCaseDTO(
                id: $0["id"] as? Int,
                word: $0["word"] as? String,
                syllables: $0["syllables"] as? [String],
                category: $0["category"] as? String,
                initialQuestion: $0["initialQuestion"] as? String,
                level: levelInsert,
                hints: $0["tips"] as? [String]
            )
        }
        
    }
    
    
}
