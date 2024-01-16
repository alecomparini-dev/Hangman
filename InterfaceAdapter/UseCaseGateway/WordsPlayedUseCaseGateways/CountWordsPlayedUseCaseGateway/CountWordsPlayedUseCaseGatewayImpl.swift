//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

import Domain
import Handler

public class CountWordsPlayedUseCaseGatewayImpl: CountWordsPlayedUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let wordsPlayedCollection: String = K.Collections.wordsPlayed
    
    private let fetchCountDataStorage: FetchCountDataStorageProvider
    
    public init(fetchCountDataStorage: FetchCountDataStorageProvider) {
        self.fetchCountDataStorage = fetchCountDataStorage
    }
    
    public func count(userID: String) async throws -> Int {
        let document = makeDocument(userID: userID)
        return try await fetchCountDataStorage.fetchCount(document)
    }
    
//  MARK: - PRIVATE AREA
    private func makeDocument(userID: String) -> String {
        return "\(usersCollection)/\(userID)/\(wordsPlayedCollection)"
    }
    
}
