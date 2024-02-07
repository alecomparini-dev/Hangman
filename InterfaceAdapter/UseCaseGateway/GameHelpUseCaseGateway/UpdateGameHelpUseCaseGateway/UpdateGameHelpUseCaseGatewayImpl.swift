//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation
import Domain
import Handler

public class UpdateGameHelpUseCaseGatewayImpl: UpdateGameHelpUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let gameCollection: String = K.Collections.game
    private let helpDocumentID: String = K.Collections.Documents.help
    
    
//  MARK: - INITIALIZERS
    
    private let updateDataStorage: UpdateDataStorageProvider
    
    public init(updateDataStorage: UpdateDataStorageProvider) {
        self.updateDataStorage = updateDataStorage
    }
    
    public func update(_ userID: String, gameHelp: GameHelpModel) async throws {
        let collection = "\(usersCollection)/\(userID)/\(gameCollection)"
        
        let updateGameCodable: GameHelpCodable = GameHelpCodable.mapper(gameHelp)
        
        let updateGameJSONData = try JSONEncoder().encode(updateGameCodable)
        
        let updateGameJSON = try JSONSerialization.jsonObject(with: updateGameJSONData, options: .fragmentsAllowed) as? [String: Any]
        
        if let updateGameJSON {
            try await updateDataStorage.update(collection, helpDocumentID, updateGameJSON)
        }
        
    }
    
}
