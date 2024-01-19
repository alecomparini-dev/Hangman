//
//  SaveLastOpenHintsUseCaseGatewayImpl.swift
//  Domain
//
//  Created by Alessandro Comparini on 19/01/24.
//

import Foundation
import Domain
import Handler

public class SaveLastOpenHintsUseCaseGatewayImpl: SaveLastOpenHintsUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let openHintsCollection: String = K.Collections.openHints
    private let openHintsDocument: String = K.Collections.Documents.openHints
    
    
//  MARK: - INITIALIZERS
    
    private let insertDataStorage: InsertDataStorageProvider
    
    public init(insertDataStorage: InsertDataStorageProvider) {
        self.insertDataStorage = insertDataStorage
    }
    
    public func save(_ userID: String, _ indexes: [Int]) async throws {
        let collection = "\(usersCollection)/\(userID)/\(openHintsCollection)"
        
        let lastOpenHintsCodable: LastOpenHintsCodable = LastOpenHintsCodable.mapper(indexes)
        
        let lastOpenHintsJSONData = try JSONEncoder().encode(lastOpenHintsCodable)
        
        let lastOpenHintsJSON = try JSONSerialization.jsonObject(with: lastOpenHintsJSONData, options: .fragmentsAllowed) as? [String: Any]
        
        if let lastOpenHintsJSON {
            _ = try await insertDataStorage.insert(collection, openHintsDocument, lastOpenHintsJSON)
        }
        
    }
    
}
