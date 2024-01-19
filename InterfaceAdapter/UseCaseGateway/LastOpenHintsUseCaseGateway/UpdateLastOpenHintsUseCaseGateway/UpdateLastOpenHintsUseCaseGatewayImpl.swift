//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation
import Domain
import Handler

public class UpdateLastOpenHintsUseCaseGatewayImpl: UpdateLastOpenHintsUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let openHintsCollection: String = K.Collections.openHints
    private let openHintsDocument: String = K.Collections.Documents.openHints
    
    
//  MARK: - INITIALIZERS
    
    private let updateDataStorage: UpdateDataStorageProvider
    
    public init(updateDataStorage: UpdateDataStorageProvider) {
        self.updateDataStorage = updateDataStorage
    }
    
    public func update(_ userID: String, _ indexes: [Int]) async throws {
        let collection = "\(usersCollection)/\(userID)/\(openHintsCollection)"
        
        let lastOpenHintsCodable: LastOpenHintsCodable = LastOpenHintsCodable.mapper(indexes)
        
        let lastOpenHintsJSONData = try JSONEncoder().encode(lastOpenHintsCodable)
        
        let lastOpenHintsJSON = try JSONSerialization.jsonObject(with: lastOpenHintsJSONData, options: .fragmentsAllowed) as? [String: Any]
        
        if let lastOpenHintsJSON {
            _ = try await updateDataStorage.update(collection, openHintsDocument, lastOpenHintsJSON)
        }
        
    }
    
}
