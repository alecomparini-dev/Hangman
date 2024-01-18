//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation
import Domain
import Handler

public class GetLastOpenHintsUseCaseGatewayImpl: GetLastOpenHintsUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let openHintsCollection: String = K.Collections.openHints
    
    private let indexesField = K.String.indexes
    
    private let fetchDataStorage: FetchDataStorageProvider
    
    public init(fetchDataStorage: FetchDataStorageProvider) {
        self.fetchDataStorage = fetchDataStorage
    }
    
    public func get(_ userID: String) async throws -> [Int] {
        let collection = "\(usersCollection)/\(userID)/\(openHintsCollection)"
        
        let dictResult: [Dictionary<String,Any>]? = try await fetchDataStorage.fetch(collection)
        
        guard let result = dictResult?.first else { return [] }
        
        let dictData: Data = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
        
        let lastOpenHintsCodable: LastOpenHintsCodable = try JSONDecoder().decode(LastOpenHintsCodable.self, from: dictData)
        
        return lastOpenHintsCodable.indexes ?? []
    }
    
}
