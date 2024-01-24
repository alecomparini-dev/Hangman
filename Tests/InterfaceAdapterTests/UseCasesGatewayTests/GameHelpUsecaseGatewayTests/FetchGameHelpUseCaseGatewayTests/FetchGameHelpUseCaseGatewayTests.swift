//  Created by Alessandro Comparini on 23/01/24.
//

import XCTest
import Handler
import Domain
import UseCaseGateway

final class FetchGameHelpUseCaseGatewayTests: XCTestCase {
    
    let userID = "123"
    var sut: FetchGameHelpUseCaseGatewayImpl!
    var findByDataStorageSpy: FindByDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.findByDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        findByDataStorageSpy = nil
    }
    
    
//  MARK: - TESTE AREA
    func test_fetch_gameHelp_success() async {
        let expectedResult = GameHelpModelFactory.make()
        
        findByDataStorageSpy.findByResult = .success(GameHelpModelFactory.makeJSON())
        
        do {
            let result = try await sut.fetch(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_fetchGameHelp_return_nil_success() async {
        findByDataStorageSpy.findByResult = .success(nil)
        
        do {
            let result = try await sut.fetch(userID)
            XCTAssertNil(result)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_fetchGameHelp_throw() async {
        findByDataStorageSpy.findByResult = .failure(MockError.throwError)
        
        do {
            let result = try await sut.fetch(userID)
            XCTFail("Unexpected success: \(String(describing: result) )")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    

    func test_fetchGameHelp_codable_wrong_throw() async {
        let expectedResult = GameHelpModel(typeGameHelp: TypeGameHelpModel(revelations: 3))
        
        findByDataStorageSpy.findByResult = .success(makeFindByWrongJson())
        
        do {
            let result = try await sut.fetch(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_fetchGameHelp_helpDocument_success() async {
        findByDataStorageSpy.findByResult = .success([:])
        
        do {
            _ = try await sut.fetch(userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(findByDataStorageSpy.helpDocument, K.Collections.Documents.help)
    }
    
    func test_fetchGameHelp_path_success() async {
        findByDataStorageSpy.findByResult = .failure(MockError.throwError)
        
        do {
            _ = try await sut.fetch(userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(findByDataStorageSpy.path, "\(K.Collections.users)/\(userID)/\(K.Collections.game)")
    }

}


//  MARK: - EXTENSION SUT
extension FetchGameHelpUseCaseGatewayTests {
        
    func makeSut() -> (sut: FetchGameHelpUseCaseGatewayImpl, fetchDataStorageProviderSpy: FindByDataStorageProviderSpy) {
        let fetchDataStorageSpy = FindByDataStorageProviderSpy()
        let sut = FetchGameHelpUseCaseGatewayImpl(fetchDataStorage: fetchDataStorageSpy)
        return (sut, fetchDataStorageSpy)
    }
    
    func makeFindByWrongJson() -> [String: Any] {
        return [
            "dateFree": "2024-01-12",
            "live": 1,
            "hint": 2,
            "revelations": 3
        ]
    }
        
}







