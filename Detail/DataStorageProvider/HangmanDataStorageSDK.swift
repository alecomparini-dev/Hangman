//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import UseCaseGateway
import DataStorageSDKMain

public class HangmanDataStorageSDK {
    
    private let dataStorage: DataStorageMain

    public init(dataStorage: DataStorageMain) {
        self.dataStorage = dataStorage
    }
        
}


//  MARK: - EXTENSION - FetchByDataStorageProvider
extension HangmanDataStorageSDK: FetchByDataStorageProvider {
    public func fetchBy<T>(id: String) async throws -> T? {
        return try await dataStorage.fetchById(id)
    }
}

//  MARK: - EXTENSION - FetchCountDataStorageProvider
extension HangmanDataStorageSDK: FetchCountDataStorageProvider {
    public func fetchCount() async throws -> Int {
        return try await dataStorage.fetchCount()
    }
}
