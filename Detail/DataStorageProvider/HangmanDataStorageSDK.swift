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


//  MARK: - EXTENSION - FindByDataStorageProvider

extension HangmanDataStorageSDK: FindByDataStorageProvider {
    public func findBy<T>(id: String) async throws -> T? {
        return try await dataStorage.findBy(id)
    }
    
    public func findBy<T>(_ path: String, _ documentID: String) async throws -> T? {
        return try await dataStorage.findBy(path, documentID)
    }    
    
}


//  MARK: - EXTENSION - FetchDataStorageProvider

extension HangmanDataStorageSDK: FetchDataStorageProvider {
    public func fetch<T>() async throws -> [T] {
        return try await dataStorage.fetch()
    }
    
    public func fetch<T>(_ document: String) async throws -> [T] {
        return try await dataStorage.fetch(document)
    }
        
}



//  MARK: - EXTENSION - FetchCountDataStorageProvider
extension HangmanDataStorageSDK: FetchCountDataStorageProvider {
    public func fetchCount(_ document: String) async throws -> Int {
        return try await dataStorage.fetchCount(document)
    }
    
}



//  MARK: - EXTENSION - InsertDataStorageProvider
extension HangmanDataStorageSDK: InsertDataStorageProvider {
    public func insert<T>(_ path: String, _ documentID: String, _ value: T) async throws -> T? {
        return try await dataStorage.create(path, documentID, value)
    }
    
    public func insert<T>(_ value: T) async throws -> T? {
        return try await dataStorage.create(value)
    }
    
    public func insert<T>(_ collection: String, _ value: T) async throws -> T? {
        return try await dataStorage.create(collection, value)
    }
        
}


//  MARK: - EXTENSION - UpdateDataStorageProvider
extension HangmanDataStorageSDK: UpdateDataStorageProvider {
    
    public func update<T>(_ collection: String, _ documentID: String, _ value: T) async throws {
        return try await dataStorage.update(collection, documentID, value)
    }
    
    
}

