//
//  FetchGameHelpUseCaseTests.swift
//  TestsDomain
//
//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class FetchGameHelpUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: FetchGameHelpUseCaseImpl!
    var fetchGameHelpGatewaySpy: FetchGameHelpUseCaseGatewaySpy!
    var saveGameHelpGatewaySpy: SaveGameHelpUseCaseGatewaySpy!
    var maxGameHelpUseCaseSpy: MaxGameHelpUseCaseSpy!
    
    override func setUp() {
        self.fetchGameHelpGatewaySpy = FetchGameHelpUseCaseGatewaySpy()
        self.saveGameHelpGatewaySpy = SaveGameHelpUseCaseGatewaySpy()
        self.maxGameHelpUseCaseSpy = MaxGameHelpUseCaseSpy()
        self.sut = FetchGameHelpUseCaseImpl(fetchGameHelpGateway: fetchGameHelpGatewaySpy,
                                            saveGameHelpGateway: saveGameHelpGatewaySpy,
                                            maxGameHelpUseCase: maxGameHelpUseCaseSpy)
    }
    
    override func tearDown() {
        sut = nil
        fetchGameHelpGatewaySpy = nil
        saveGameHelpGatewaySpy = nil
        maxGameHelpUseCaseSpy = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_fetch_success() async {
        let expectedResult = FetchGameHelpUseCaseDTOFactory.make()
        
        fetchGameHelpGatewaySpy.result = .success(GameHelpModelFactory.make())
        
        do {
            let result = try await sut.fetch(userID)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_fetch_failure() async {
        fetchGameHelpGatewaySpy.result = .failure(MockError.throwError)
        do {
            _ = try await sut.fetch(userID)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_fetch_and_save_initial_gameHelp() async {
        let expectedResult = FetchGameHelpUseCaseDTOFactory.make()
        
        fetchGameHelpGatewaySpy.result = .success(nil)
        
        do {
            let result = try await sut.fetch(userID)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func test_fetch_and_renew_freeGameHelp() async {
        let expectedResult = FetchGameHelpUseCaseDTOFactory.make()
        
        fetchGameHelpGatewaySpy.result = .success(GameHelpModelFactory.make(lives: 2, hints: 6, revelations: 4))
        
        do {
            let result = try await sut.fetch(userID)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
    }

    func test_fetch_and_typeGames_nill() async {
        let expectedResult = FetchGameHelpUseCaseDTOFactory.make()
        
        fetchGameHelpGatewaySpy.result = .success(GameHelpModel(
            dateRenewFree: DateHandler.convertDate("2024-1-12"),
            typeGameHelp: TypeGameHelpModel())
        )
        
        do {
            let result = try await sut.fetch(userID)
            
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func test_fetch_and_save_initialGameHelp_failure() async {

        saveGameHelpGatewaySpy.result = .failure(MockError.throwError)
        fetchGameHelpGatewaySpy.result = .success(nil)
        
        do {
            _ = try await sut.fetch(userID)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
        
    }
    
    
}
