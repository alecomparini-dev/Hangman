//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class DataStorageFetchAtIDNexWordsUseCaseGatewayTests: XCTestCase {
    
    var sut: DataStorageFetchAtIDNexWordsUseCaseGatewayImpl!
    var fetchAtIDDataStorage: FetchAtDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.fetchAtIDDataStorage) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        fetchAtIDDataStorage = nil
    }
    
    func test_nextWords_without_limit_success() async {
        let expectedResult = [NextWordsUseCaseDTOFactory.make()]
        
        fetchAtIDDataStorage.result = .success([NextWordsUseCaseDTOFactory.toJSON()])
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: nil)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_nextWords_without_limit_failure() async {
        fetchAtIDDataStorage.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: nil)
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_nextWords_using_limit_success() async {
        let expectedResult = [NextWordsUseCaseDTOFactory.make()]
        
        fetchAtIDDataStorage.result = .success([NextWordsUseCaseDTOFactory.toJSON()])
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: 10)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_nextWords_using_limit_failure() async {
        fetchAtIDDataStorage.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: 10)
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_nextWords_return_nil_success() async {
        let expectedResult = [NextWordsUseCaseDTO]()
        
        fetchAtIDDataStorage.result = .success(nil)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: 10)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_update_correct_values() async {
        do {
            _ = try await sut.nextWords(atID: 1, limit: 10)
            XCTAssertEqual(fetchAtIDDataStorage.id, 1)
            XCTAssertEqual(fetchAtIDDataStorage.limit, 10)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}

//  MARK: - EXTENSION SUT
extension DataStorageFetchAtIDNexWordsUseCaseGatewayTests {
        
    func makeSut() -> (sut: DataStorageFetchAtIDNexWordsUseCaseGatewayImpl, fetchAtIDDataStorage: FetchAtDataStorageProviderSpy) {
        let fetchAtIDDataStorage = FetchAtDataStorageProviderSpy()
        let sut = DataStorageFetchAtIDNexWordsUseCaseGatewayImpl(fetchAtIDDataStorage: fetchAtIDDataStorage)
        return (sut, fetchAtIDDataStorage)
    }
    
}

