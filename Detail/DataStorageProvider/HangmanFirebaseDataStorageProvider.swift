//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation


import FirebaseFirestore
import UseCaseGateway
import DataStorageSDKMain

public class HangmanFirebaseDataStorageProvider {
        
    private var db: Firestore!
    
    private let collection: String
    
    public init(collection: String) {
        self.collection = collection
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
        
}


//  MARK: - EXTENSION - FetchAtIDDataStorageProvider
extension HangmanFirebaseDataStorageProvider: FetchAtDataStorageProvider {
    
    public func fetchAt<T>(id: Int = 0) async throws -> T? {
        let querySnapshot: QuerySnapshot = try await db.collection(collection)
            .whereField("id", isGreaterThanOrEqualTo: id)
            .getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }

    public func fetchAt<T>(id: Int = 0, limit: Int) async throws -> T? {
        let querySnapshot: QuerySnapshot = try await db.collection(collection)
            .limit(to: limit)
            .whereField("id", isGreaterThanOrEqualTo: id)
            .getDocuments()        
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }

}


//  MARK: - EXTENSION - FetchInDataStorageProvider
extension HangmanFirebaseDataStorageProvider: FetchInDataStorageProvider {
    
    public func fetchIn<T>(id: [Int]) async throws -> T? {
        let querySnapshot: QuerySnapshot = try await db.collection(collection)
            .whereField("id", in: id)
            .getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }
    
    
    public func fetchNotIn<T>(id: [Int]) async throws -> T? {
        let querySnapshot: QuerySnapshot = try await db.collection(collection)
            .whereField("id", notIn: id)
            .getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }
    
    
    public func fetchIn<D,T>(column: String, _ values: [D]) async throws -> T? {
        let querySnapshot: QuerySnapshot = try await db.collection(collection)
            .whereField(column, in: values)
            .getDocuments()
        
        let data: [QueryDocumentSnapshot] = querySnapshot.documents
        
        return data.map { $0.data() } as? T
    }

}

