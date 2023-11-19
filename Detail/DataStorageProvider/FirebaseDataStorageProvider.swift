//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation


import FirebaseFirestore
import UseCaseGateway
import DataStorageSDKMain

public class FirebaseDataStorageProvider {
        
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
extension FirebaseDataStorageProvider: FetchAtIDDataStorageProvider {
    
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

