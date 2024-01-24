//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class SignInAnonymousUseCaseGatewayTests: XCTestCase {
    
    var sut: SignInAnonymousUseCaseGatewayImpl!
    var signInAnonymousSpy: AuthenticateAnonymousSpy!
    
    override func setUp() {
        (self.sut, self.signInAnonymousSpy) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        signInAnonymousSpy = nil
    }
    
    func test_get_success() async {
        let expectedResult = "userID"
        
        signInAnonymousSpy.result = .success(expectedResult)
        
        do {
            let result = try await sut.signInAnonymosly()
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_get_failure() async {
        signInAnonymousSpy.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.signInAnonymosly()
            XCTFail("Unexpected success: \(String(describing: result))")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
}



//  MARK: - EXTENSION SUT
extension SignInAnonymousUseCaseGatewayTests {
        
    func makeSut() -> (sut: SignInAnonymousUseCaseGatewayImpl, signInAnonymousProvider: AuthenticateAnonymousSpy) {
        let signInAnonymousProvider = AuthenticateAnonymousSpy()
        let sut = SignInAnonymousUseCaseGatewayImpl(signInAnonymousProvider: signInAnonymousProvider)
        return (sut, signInAnonymousProvider)
    }
        
}

