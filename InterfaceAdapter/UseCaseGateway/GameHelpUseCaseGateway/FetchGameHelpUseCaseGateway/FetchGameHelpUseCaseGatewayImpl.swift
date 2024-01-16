//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

import Domain
import Handler

public class FetchGameHelpUseCaseGatewayImpl: FetchGameHelpUseCaseGateway {
    private let usersCollection: String = K.Collections.users
    private let gamepCollection: String = K.Collections.game
    private let helpDocument: String = K.Collections.game
    
    private let fetchDataStorage: FetchDataStorageProvider
    
    public init(fetchDataStorage: FetchDataStorageProvider) {
        self.fetchDataStorage = fetchDataStorage
    }

    public func fetch(_ userID: String) async throws -> GameHelpModel? {
        let document = "\(usersCollection)/\(userID)/\(gamepCollection)"
        
        let dictResult: [[String: Any]] = try await fetchDataStorage.fetch(document)
        
        guard let result = dictResult.first else { return nil }
        
        let dictData: Data = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
        
        let fetchGameHelpCodable: FetchGameHelpCodable = try JSONDecoder().decode(FetchGameHelpCodable.self, from: dictData)
        
        return fetchGameHelpCodable.mapperToGameHelp()
    }
    
    
}
