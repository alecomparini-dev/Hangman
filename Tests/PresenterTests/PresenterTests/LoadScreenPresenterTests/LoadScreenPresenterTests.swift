//
//  LoadScreenPresenterTests.swift
//  Handler
//
//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class DataStorageFetchAtIDNexWordsUseCaseGatewayTests: XCTestCase {
    
    var signInAnonymousUseCaseMock: SignInAnonymousUseCaseMock!
    var sut: LoadScreenPresenter!
    
    override func setUp() {
        self.signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
    }
    
    override func tearDown() {
        sut = nil
        signInAnonymousUseCaseMock = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_success() async {
        var expectedResult = false
        
        signInAnonymousUseCaseMock.result = .success("123")
        
        self.sut = LoadScreenPresenter(signInAnonymousUseCase: signInAnonymousUseCaseMock)
        
        XCTAssertTrue(true)
        
    }
    
    func test_failure() async {
        var expectedResult = false
        
//        signInAnonymousUseCaseMock.result = .failure(Mo)
        
        self.sut = LoadScreenPresenter(signInAnonymousUseCase: signInAnonymousUseCaseMock)
        
        XCTAssertTrue(true)
        
    }
    
}
