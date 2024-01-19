//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation
import Domain
import Handler

public class GetLastOpenHintsUseCaseGatewayImpl: GetLastOpenHintsUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let openHintsCollection: String = K.Collections.openHints
    private let openHintsDocument: String = K.Collections.Documents.openHints
    
    private let indexesField = K.String.indexes
    
    private let findByDataStorage: FindByDataStorageProvider
    
    public init(findByDataStorage: FindByDataStorageProvider) {
        self.findByDataStorage = findByDataStorage
    }
    
    public func get(_ userID: String) async throws -> [Int] {
        let collection = "\(usersCollection)/\(userID)/\(openHintsCollection)"
        
        guard let dictResult: Dictionary<String,Any> = try await findByDataStorage.findBy(collection, openHintsDocument) else { return [] }
        
        let dictData: Data = try JSONSerialization.data(withJSONObject: dictResult, options: .fragmentsAllowed)
        
        let lastOpenHintsCodable: LastOpenHintsCodable = try JSONDecoder().decode(LastOpenHintsCodable.self, from: dictData)
        
        return lastOpenHintsCodable.indexes ?? []
    }
    
}
