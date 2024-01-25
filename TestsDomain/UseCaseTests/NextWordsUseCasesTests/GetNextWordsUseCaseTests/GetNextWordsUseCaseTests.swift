//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class GetNextWordsUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: GetNextWordsUseCaseImpl!
    var nextWordsGateway: GetNextWordsUseCaseGatewaySpy!
    
    override func setUp() {
        self.nextWordsGateway = GetNextWordsUseCaseGatewaySpy()
        self.sut = GetNextWordsUseCaseImpl(nextWordsGateway: nextWordsGateway)
    }
    
    override func tearDown() {
        sut = nil
        nextWordsGateway = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_nextWords_success() async {
        let expectedResult = [NextWordsUseCaseDTOFactory.make()]
        
        nextWordsGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: 10)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_nextWords_failure() async {
        nextWordsGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.nextWords(atID: 1, limit: 10)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_nextWords_correct_values() async {
        let expectedResult = [NextWordsUseCaseDTOFactory.make()]
        
        nextWordsGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: 10)
            
            XCTAssertEqual(result, expectedResult)
            XCTAssertEqual(nextWordsGateway.atID, 1)
            XCTAssertEqual(nextWordsGateway.limit, 10)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_nextWords_limit_nil() async {
        let expectedResult = [NextWordsUseCaseDTOFactory.make()]
        
        nextWordsGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.nextWords(atID: 1, limit: nil)
            
            XCTAssertEqual(result, expectedResult)
            XCTAssertEqual(nextWordsGateway.atID, 1)
            XCTAssertEqual(nextWordsGateway.limit, nil)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        
    }
    
}
