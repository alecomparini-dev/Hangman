//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

import UseCaseGateway
import DataStorageSDKMain

public class HangmanDataStorageSDK {
    
    private let dataStorage: DataStorageProviderStrategy

    public init(dataStorage: DataStorageProviderStrategy) {
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
    public func fetchCount(_ document: String) async throws -> Int {
        return try await dataStorage.fetchCount(document)
    }
    
    public func fetchCount() async throws -> Int {
        return try await dataStorage.fetchCount()
    }
}



//  MARK: - EXTENSION - InsertDataStorageProvider
extension HangmanDataStorageSDK: InsertDataStorageProvider {

    public func insert<T>(_ document: String, _ value: T) async throws -> T? {
        return try await dataStorage.create(document, value)
    }

    public func insert<T>(_ value: T) async throws -> T? {
        return try await dataStorage.create(value)
    }
}
