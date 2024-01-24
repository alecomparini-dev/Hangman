//
//  FetchGameHelpUseCaseTests.swift
//  TestsDomain
//
//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
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
    
    func test_save_success() async {
        let expectedResult = [FetchGameHelpUseCaseDTOFactory.make()]
        
        fetchGameHelpGatewaySpy.result = .success(GameHelpModelFactory.make())
        
//        do {
//            let result = try await sut.nextWords(atID: 1, limit: nil)
//            XCTAssertEqual(result, expectedResult)
//        } catch let error {
//            XCTFail("Unexpected error: \(error)")
//        }
    }
}
