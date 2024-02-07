//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

import Domain
import Handler

public class SaveWordPlayedUseCaseGatewayImpl: SaveWordPlayedUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let wordsPlayedCollection: String = K.Collections.wordsPlayed
    
    private let insertDataStorage: InsertDataStorageProvider
    
    public init(insertDataStorage: InsertDataStorageProvider) {
        self.insertDataStorage = insertDataStorage
    }
        
    public func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws {
        
        let saveWordPlayedCodable: SaveWordPlayedCodable = WordPlayedUseCaseDTOToSaveWordPlayedCodableMapper.mapper(wordPlayedDTO: wordPlayed)
        
        let saveWordPlayedJsonData = try JSONEncoder().encode(saveWordPlayedCodable)
        
        let value: [String: Any]? = try JSONSerialization.jsonObject(with: saveWordPlayedJsonData, options: .fragmentsAllowed) as? [String: Any]
        
        _ = try await insertDataStorage.insert(makePath(userID), wordPlayed.id.description, value)
    }

    
//  MARK: - PRIVATE AREA
    private func makePath(_ userID: String) -> String {
        return "\(usersCollection)/\(userID)/\(wordsPlayedCollection)"
    }
}
