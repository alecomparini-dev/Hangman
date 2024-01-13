//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public class GameHelpManagerUseCaseImpl: FetchGameHelpManagerUseCase {
    private struct maxFreeHelps {
        static let freeLives: Int8 = 5
        static let freeHints: Int8 = 10
        static let freeRevelations: Int8 = 5
    }
    
    
    public func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO? {
        
        return nil
    }
    
    
    public func insert(_ userID: String, gameHelp: GameHelpModel) async throws {
        
    }

    
//  MARK: - PRIVATE AREA
    private func renewFreeHelp(_ gameHelp: GameHelpModel) async throws {
        
    }
    
    
}
