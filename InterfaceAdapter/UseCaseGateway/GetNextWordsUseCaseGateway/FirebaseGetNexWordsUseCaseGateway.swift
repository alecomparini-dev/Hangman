//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import Domain


public class FirebaseGetNexWordsUseCaseGatewayImpl: GetNextWordsUseCaseGateway {
    
    private let fetchStorageProvider: FetchDataStorageProvider
    
    public init(fetchStorageProvider: FetchDataStorageProvider) {
        self.fetchStorageProvider = fetchStorageProvider
    }
    
    
    public func nextWords(at: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO] {
        
        var fetchWords: [[String: Any]]?
        
        if let limit {
            fetchWords = try await fetchStorageProvider.fetch(limit: limit)
        } else {
            fetchWords = try await fetchStorageProvider.fetch()
        }
        
        guard let fetchWords else {return []}
        
        return fetchWords.map {
            return GetNextWordsUseCaseDTO(
                id: $0["id"] as? Int,
                word: $0["word"] as? String,
                syllables: $0["syllables"] as? [String],
                category: $0["category"] as? String,
                initialTip: $0["initialTip"] as? String,
                tips: $0["tips"] as? [String]
            )
        }
        
    }
    
    
}
