//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class GenericCountModelGatewayTests: XCTestCase {
    
    var sut: GenericCountModelGatewayImpl!
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
            let result = try await sut.count("any_document")
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_count_failure() async {
        fetchCountDataStorage.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.count("any_document")
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_count_correct_document_success() async {
        let expectedResult = "any_document"
        
        fetchCountDataStorage.result = .success(1)
        
        do {
            _ = try await sut.count("any_document")
        } catch let error {
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(fetchCountDataStorage.document, expectedResult)
    }
    
}

//  MARK: - EXTENSION SUT
extension GenericCountModelGatewayTests {
        
    func makeSut() -> (sut: GenericCountModelGatewayImpl, fetchCountDataStorage: FetchCountDataStorageProviderSpy) {
        let fetchCountDataStorage = FetchCountDataStorageProviderSpy()
        let sut = GenericCountModelGatewayImpl(fetchCountDataStorage: fetchCountDataStorage)
        return (sut, fetchCountDataStorage)
    }
    
}
