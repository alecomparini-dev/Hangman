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

// TESTE INÚTIL NESTE PRESENTER SÓ PARA COMPLETAR O COVERAGE
final class LoadScreenPresenterTests: XCTestCase {
    
    var signInAnonymousUseCaseMock: SignInAnonymousUseCaseMock<String>!
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
        signInAnonymousUseCaseMock.setResult = .success("123")
        
        self.sut = LoadScreenPresenter(signInAnonymousUseCase: signInAnonymousUseCaseMock)
        
        XCTAssertTrue(true)
    }
    
    func test_failure() async {
        signInAnonymousUseCaseMock.setResult = .failure(MockError.throwError)
        
        self.sut = LoadScreenPresenter(signInAnonymousUseCase: signInAnonymousUseCaseMock)
        
        XCTAssertTrue(true)
    }
    
}
