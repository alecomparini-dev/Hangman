//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class GetDollsRandomUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: GetDollsRandomUseCaseImpl!
    var countDollsUseCaseMock: CountDollsUseCaseMock!
    var getDollsGatewaySpy: GetDollsUseCaseGatewaySpy!
    
    override func setUp() {
        self.countDollsUseCaseMock = CountDollsUseCaseMock()
        self.getDollsGatewaySpy = GetDollsUseCaseGatewaySpy()
        self.sut = GetDollsRandomUseCaseImpl(countDollsUseCase: countDollsUseCaseMock,
                                             getDollsGateway: getDollsGatewaySpy)
    }
    
    override func tearDown() {
        sut = nil
        countDollsUseCaseMock = nil
        getDollsGatewaySpy = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_getDollsRandom_and_countDolls_success() async {
        let expectedResult = [DollUseCaseDTOFactory.make()]
        
        countDollsUseCaseMock.result = .success(2)
        getDollsGatewaySpy.result = .success([DollUseCaseDTOFactory.make()])
        
        do {
            let result = try await sut.getDollsRandom(quantity: 2)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_getDollsRandom_failure_countDoll_success() async {
        countDollsUseCaseMock.result = .success(2)
        getDollsGatewaySpy.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.getDollsRandom(quantity: 2)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_getDollsRandom_countDoll_failure() async {
        countDollsUseCaseMock.result = .failure(MockError.throwError)
        getDollsGatewaySpy.result = .success([])
        
        do {
            _ = try await sut.getDollsRandom(quantity: 2)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_getDollsRandom_quantity_less_than_countDoll() async {
        let expectedResult = [DollUseCaseDTOFactory.make(), DollUseCaseDTOFactory.make()]
        let quantity = 2
        
        countDollsUseCaseMock.result = .success(5)
        getDollsGatewaySpy.result = .success(expectedResult)
        
        do {
            let result = try await sut.getDollsRandom(quantity: quantity)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_getDollsRandom_correct_values_to_quantity_less_than_countDoll() async {
        let expectedResult = [DollUseCaseDTOFactory.make(), DollUseCaseDTOFactory.make()]
        let expectedQuantity = 2
        
        countDollsUseCaseMock.result = .success(5)
        getDollsGatewaySpy.result = .success([DollUseCaseDTOFactory.make(), DollUseCaseDTOFactory.make()])
        
        do {
            let result = try await sut.getDollsRandom(quantity: expectedQuantity)
            
            XCTAssertEqual(getDollsGatewaySpy.id.count, expectedQuantity)
            XCTAssertEqual(result, expectedResult)
            XCTAssertEqual(result.count, expectedQuantity)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        
    }
}
