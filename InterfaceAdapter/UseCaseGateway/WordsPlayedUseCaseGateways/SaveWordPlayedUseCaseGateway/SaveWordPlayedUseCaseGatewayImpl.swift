//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

import Domain

public class SaveWordPlayedUseCaseGatewayImpl: SaveWordPlayedUseCaseGateway {
    
    private let insertDataStorage: InsertDataStorageProvider
    
    public init(insertDataStorage: InsertDataStorageProvider) {
        self.insertDataStorage = insertDataStorage
    }
        
    public func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws {
        let document = makeDocument(userID: userID, wordPlayed)
        
        let saveWordPlayedCodable: SaveWordPlayedCodable = WordPlayedUseCaseDTOToSaveWordPlayedCodableMapper.mapper(wordPlayedDTO: wordPlayed)
        
        let saveWordPlayedJsonData = try JSONEncoder().encode(saveWordPlayedCodable)
        
        let value: [String: Any]? = try JSONSerialization.jsonObject(with: saveWordPlayedJsonData, options: .fragmentsAllowed) as? [String: Any]
        
        _ = try await insertDataStorage.insert(document, value)
    }

    
//  MARK: - PRIVATE AREA
    private func makeDocument(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) -> String {
        return userID + "/words/\(wordPlayed.wordID)"
    }
}
