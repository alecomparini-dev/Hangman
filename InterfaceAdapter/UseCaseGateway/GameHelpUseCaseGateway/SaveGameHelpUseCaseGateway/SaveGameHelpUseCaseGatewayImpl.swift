//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation
import Domain
import Handler

public class SaveGameHelpUseCaseGatewayImpl: SaveGameHelpUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let gameCollection: String = K.Collections.game
    private let helpDocumentID: String = K.Collections.Documents.help
    

//  MARK: - INITIALIZERS
    private let insertDataStorage: InsertDataStorageProvider
    
    public init(insertDataStorage: InsertDataStorageProvider) {
        self.insertDataStorage = insertDataStorage
    }
    
    
//  MARK: - PUBLIC AREA
    public func save(_ userID: String, gameHelp: GameHelpModel) async throws {
        let collection = makeCollection(userID)
                
        let saveGameCodable: SaveGameHelpCodable = SaveGameHelpCodable.mapper(gameHelp)
        
        let saveGameJSONData = try JSONEncoder().encode(saveGameCodable)
        
        let saveGameJSON = try JSONSerialization.jsonObject(with: saveGameJSONData, options: .fragmentsAllowed) as? [String: Any]
        
        if let saveGameJSON {
            _ = try await insertDataStorage.insert(collection, helpDocumentID, saveGameJSON)
        }
        
    }
    
//  MARK: - PRIVATE AREA
    private func makeCollection(_ userID: String) -> String {
        return "\(usersCollection)/\(userID)/\(gameCollection)"
    }
}
