//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

import Domain
import Handler

public class CountWordsPlayedUseCaseGatewayImpl: CountWordsPlayedUseCaseGateway {
    
    private let fetchCountDataStorage: FetchCountDataStorageProvider
    
    public init(fetchCountDataStorage: FetchCountDataStorageProvider) {
        self.fetchCountDataStorage = fetchCountDataStorage
    }
    
    public func count(userID: String) async throws -> Int {
        let document = userID + "/\(K.String.wordsPlayed)"
        return try await fetchCountDataStorage.fetchCount(document)
    }
    
}
