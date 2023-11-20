//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

import Domain

public class CountWordsPlayedUseCaseGatewayImpl: CountWordsPlayedUseCaseGateway {
    
    private let fetchCountDataStorage: FetchCountDataStorageProvider
    
    public init(fetchCountDataStorage: FetchCountDataStorageProvider) {
        self.fetchCountDataStorage = fetchCountDataStorage
    }
    
    public func count(userID: String) async throws -> Int {
        let document = userID + "/words"
        return try await fetchCountDataStorage.fetchCount(document)
    }
    
}
