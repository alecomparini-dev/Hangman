//  Created by Alessandro Comparini on 23/01/24.
//

import XCTest
import Handler
import Domain
import UseCaseGateway

final class FetchGameHelpUseCaseGatewayTests: XCTestCase {
    
    func testFetchGameHelpSuccess() async {
        let userID = "123"
        let expectedResult = makeGameHelpModel()
        let (sut, findByDataStorageSpy) = makeSut()
        
        findByDataStorageSpy.findByResult = .success(makeFindBySuccessJson())
        
        do {
            let result = try await sut.fetch(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func test_fetchGameHelp_return_nil_success() async {
        let userID = "123"
        let (sut, findByDataStorageSpy) = makeSut()
        
        findByDataStorageSpy.findByResult = .success(nil)
        
        do {
            let result = try await sut.fetch(userID)
            XCTAssertNil(result)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
    }
    
    func test_fetchGameHelp_throw() async {
        let userID = "123"
        let (sut, findByDataStorageSpy) = makeSut()
        
        findByDataStorageSpy.findByResult = .failure(MockError.throwError)
        
        do {
            let result = try await sut.fetch(userID)
            XCTFail("Unexpected success: \(String(describing: result) )")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
        
    }
    

    func test_fetchGameHelp_codable_wrong_throw() async {
        let userID = "123"
        let (sut, findByDataStorageSpy) = makeSut()
        
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
        let userID = "123"
        let (sut, findByDataStorageSpy) = makeSut()
        
        findByDataStorageSpy.findByResult = .success([:])
        do {
            _ = try await sut.fetch(userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
        XCTAssertEqual(findByDataStorageSpy.helpDocument, K.Collections.Documents.help)
    }
    
    func test_fetchGameHelp_path_success() async {
        let userID = "123"
        let (sut, findByDataStorageSpy) = makeSut()
        
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
    
    enum MockError: Error {
        case throwError
    }
    
    func makeSut() -> (sut: FetchGameHelpUseCaseGatewayImpl, fetchDataStorageProviderSpy: FindByDataStorageProviderSpy) {
        let fetchDataStorageSpy = FindByDataStorageProviderSpy()
        let sut = FetchGameHelpUseCaseGatewayImpl(fetchDataStorage: fetchDataStorageSpy)
        return (sut, fetchDataStorageSpy)
    }
    
    func makeGameHelpModel() -> GameHelpModel {
        return GameHelpModel(dateRenewFree: DateHandler.convertDate("2024-01-12"),
                             typeGameHelp: TypeGameHelpModel(lives: 1,
                                                             hints: 2,
                                                             revelations: 3)
        )
    }
    
    func makeFindBySuccessJson() -> [String: Any] {
        return [
            "dateRenewFree": "2024-01-12",
            "lives": 1,
            "hints": 2,
            "revelations": 3
        ]
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



//  MARK: - MockFetchDataStorage

class FindByDataStorageProviderSpy: FindByDataStorageProvider {
    var path: String!
    var helpDocument: String!
    var findByResult: Result<[String: Any]?, Error> = .success([:])
    
    func findBy<T>(_ path: String, _ documentID: String) async throws -> T? {
        self.path = path
        self.helpDocument = documentID
        switch findByResult {
        case .success(let data):
            return data as? T
        case .failure(let error):
            throw error
        }
    }
    
    func findBy<T>(id: String) async throws -> T? {
        return nil
    }
    
}



