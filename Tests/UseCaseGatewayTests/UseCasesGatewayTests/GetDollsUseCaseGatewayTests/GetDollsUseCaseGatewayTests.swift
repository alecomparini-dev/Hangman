//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class GetDollsUseCaseGatewayTests: XCTestCase {
    
    var sut: GetDollsUseCaseGatewayImpl!
    var fetchInDataStorage: FetchInDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.fetchInDataStorage) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        fetchInDataStorage = nil
    }
 
    func test_getDolls_success() async {
        let expectedResult = [DollUseCaseDTOFactory.make()]
        
        fetchInDataStorage.result = .success([DollUseCaseDTOFactory.toJSON()])
        
        do {
            let result = try await sut.getDolls(id: [1])
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_getDolls_failure() async {
        fetchInDataStorage.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.getDolls(id: [1])
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_getDolls_return_nil() async {
        let expectedResult: [DollUseCaseDTO] = []
        
        fetchInDataStorage.result = .success(nil)
        
        do {
            let result = try await sut.getDolls(id: [1])
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_getDolls_correct_values() async {
        let expectedResult = [1]
        
        do {
            _ = try await sut.getDolls(id: [1])
            let value = fetchInDataStorage.value as! [Int]
            XCTAssertEqual(value, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}


//  MARK: - EXTENSION SUT
extension GetDollsUseCaseGatewayTests {
        
    func makeSut() -> (sut: GetDollsUseCaseGatewayImpl, fetchInDataStorage: FetchInDataStorageProviderSpy) {
        let fetchInDataStorage = FetchInDataStorageProviderSpy()
        let sut = GetDollsUseCaseGatewayImpl(fetchInDataStorage: fetchInDataStorage)
        return (sut, fetchInDataStorage)
    }
        
}
