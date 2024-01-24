//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class CountWordsPlayedUseCaseGatewayTests: XCTestCase {
    var userID = "123"
    var sut: CountWordsPlayedUseCaseGatewayImpl!
    var fetchCountDataStorage: FetchCountDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.fetchCountDataStorage) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        fetchCountDataStorage = nil
    }
    
    func test_count_success() async {
        let expectedResult = 1
        
        fetchCountDataStorage.result = .success(1)
        
        do {
            let result = try await sut.count(userID: userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_count_failure() async {
        fetchCountDataStorage.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.count(userID: userID)
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    
    func test_count_correct_collection_success() async {
        fetchCountDataStorage.result = .success(1)
        
        do {
            let _ = try await sut.count(userID: userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(fetchCountDataStorage.document, "\(K.Collections.users)/\(userID)/\(K.Collections.wordsPlayed)")
    }
    
}


//  MARK: - EXTENSION SUT
extension CountWordsPlayedUseCaseGatewayTests {
        
    func makeSut() -> (sut: CountWordsPlayedUseCaseGatewayImpl, fetchCountDataStorage: FetchCountDataStorageProviderSpy) {
        let fetchCountDataStorage = FetchCountDataStorageProviderSpy()
        let sut = CountWordsPlayedUseCaseGatewayImpl(fetchCountDataStorage: fetchCountDataStorage)
        return (sut, fetchCountDataStorage)
    }
    
}

