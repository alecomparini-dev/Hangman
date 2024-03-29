//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

import Domain
import Handler

public class FetchGameHelpUseCaseGatewayImpl: FetchGameHelpUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let gameCollection: String = K.Collections.game
    private let helpDocument: String = K.Collections.Documents.help
    
    private let fetchDataStorage: FindByDataStorageProvider
    
    public init(fetchDataStorage: FindByDataStorageProvider) {
        self.fetchDataStorage = fetchDataStorage
    }

    public func fetch(_ userID: String) async throws -> GameHelpModel? {
        let collection = "\(usersCollection)/\(userID)/\(gameCollection)"
        
        let dictResult: [String: Any]? = try await fetchDataStorage.findBy(collection, helpDocument)
        
        guard let result = dictResult else { return nil }
        
        let dictData: Data = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
        
        let fetchGameHelpCodable: FetchGameHelpCodable = try JSONDecoder().decode(FetchGameHelpCodable.self, from: dictData)
        
        return fetchGameHelpCodable.mapperToGameHelp()
    }
    
    
}
