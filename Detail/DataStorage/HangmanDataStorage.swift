//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import UseCaseGateway
import DataStorageSDKMain

public class HangmanDataStorage {
    
    private let dataStorage: DataStorageMain

    public init(dataStorage: DataStorageMain) {
        self.dataStorage = dataStorage
    }
        
}


//  MARK: - EXTENSION - FetchDataStorage
extension HangmanDataStorage: FetchDataStorageProvider {
    
    public func fetch<T>() async throws -> T? {
        return try await dataStorage.fetch()
    }
    
    public func fetch<T>(limit: Int) async throws -> T? {
        return try await dataStorage.fetch(limit: limit)
    }
    
    public func fetchCount() async throws -> Int {
        return try await dataStorage.fetchCount()
    }
    
    public func fetchByID<T>(_ id: String) async throws -> T? {
        return nil
    }
    
    
    
}
