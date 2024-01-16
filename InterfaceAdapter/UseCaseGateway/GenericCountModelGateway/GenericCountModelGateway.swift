//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation
import Domain

public class GenericCountModelGatewayImpl: GenericCountModelGateway {
    
    private let fetchCountDataStorage: FetchCountDataStorageProvider
    
    public init(fetchCountDataStorage: FetchCountDataStorageProvider) {
        self.fetchCountDataStorage = fetchCountDataStorage
    }
    
    public func count(_ model: String) async throws -> Int {
        return try await fetchCountDataStorage.fetchCount(model)
    }    
    
}
