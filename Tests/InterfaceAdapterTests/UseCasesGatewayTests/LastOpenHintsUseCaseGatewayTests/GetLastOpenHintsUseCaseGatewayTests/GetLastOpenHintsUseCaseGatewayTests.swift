//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class GetLastOpenHintsUseCaseGatewayTests: XCTestCase {
    
    let userID = "123"
    var sut: GetLastOpenHintsUseCaseGatewayImpl!
    var findByDataStorageSpy: FindByDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.findByDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        findByDataStorageSpy = nil
    }
    
    
//  MARK: - TESTE AREA
    func test_get_success() async {
        let expectedResult = [1,2,3]
        
        findByDataStorageSpy.findByResult = .success(["indexes" : [1,2,3]])
        
        do {
            let result = try await sut.get(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_get_failure() async {
        findByDataStorageSpy.findByResult = .failure(MockError.throwError)
        
        do {
            let result = try await sut.get(userID)
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_get_open_hints_nil_success() async {
        let expectedResult:[Int] = []
        
        findByDataStorageSpy.findByResult = .success(nil)
        
        do {
            let result = try await sut.get(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_get_open_hints_wrong_success() async {
        let expectedResult:[Int] = []
        
        findByDataStorageSpy.findByResult = .success(["index":[1]])
        
        do {
            let result = try await sut.get(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_get_helpDocument_success() async {
        findByDataStorageSpy.findByResult = .success([:])
        
        do {
            _ = try await sut.get(userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(findByDataStorageSpy.helpDocument, K.Collections.Documents.openHints)
    }
    
    func test_fetchGameHelp_path_success() async {
        findByDataStorageSpy.findByResult = .failure(MockError.throwError)
        
        do {
            _ = try await sut.get(userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(findByDataStorageSpy.path, "\(K.Collections.users)/\(userID)/\(K.Collections.openHints)")
    }
    
}


//  MARK: - EXTENSION SUT
extension GetLastOpenHintsUseCaseGatewayTests {
        
    func makeSut() -> (sut: GetLastOpenHintsUseCaseGatewayImpl, findByDataStorage: FindByDataStorageProviderSpy) {
        let findByDataStorage = FindByDataStorageProviderSpy()
        let sut = GetLastOpenHintsUseCaseGatewayImpl(findByDataStorage: findByDataStorage)
        return (sut, findByDataStorage)
    }
        
}
