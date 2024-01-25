//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class SignInAnonymousUseCaseTests: XCTestCase {
    var signInAnonymousGatewayMock: SignInAnonymousUseCaseGatewayMock!
    var sut: SignInAnonymousUseCaseImpl!
    
    override func setUp() {
        self.signInAnonymousGatewayMock = SignInAnonymousUseCaseGatewayMock()
        self.sut = SignInAnonymousUseCaseImpl(signInAnonymousGateway: signInAnonymousGatewayMock)
    }
    
    override func tearDown() {
        sut = nil
        signInAnonymousGatewayMock = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_count_success() async {
        let expectedResult = "123"
        
        signInAnonymousGatewayMock.result = .success(expectedResult)
        
        do {
            let result = try await sut.signInAnonymosly()
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_count_failure() async {
        signInAnonymousGatewayMock.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.signInAnonymosly()
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
}
