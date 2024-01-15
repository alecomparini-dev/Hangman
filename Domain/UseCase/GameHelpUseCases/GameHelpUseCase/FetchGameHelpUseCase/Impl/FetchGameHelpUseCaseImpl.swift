//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public class FetchGameHelpUseCaseImpl: FetchGameHelpUseCase {
    private struct maxFreeHelps {
        static let freeLives: Int = 5
        static let freeHints: Int = 10
        static let freeRevelations: Int = 5
    }
    
    private let fetchGameHelpGateway: FetchGameHelpUseCaseGateway
    
    public init(fetchGameHelpGateway: FetchGameHelpUseCaseGateway) {
        self.fetchGameHelpGateway = fetchGameHelpGateway
    }
    
    public func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO? {
        let gameHelp: GameHelpModel = try await fetchGameHelpGateway.fetch(userID)
        
        return FetchGameHelpUseCaseDTO(
            livesCount: LivesTypeGameHelp().count(gameHelp.typeGameHelp?.lives?.channel),
            hintsCount: HintsTypeGameHelp().count(gameHelp.typeGameHelp?.hints?.channel),
            revelationsCount: RevelationsTypeGameHelp().count(gameHelp.typeGameHelp?.revelations?.channel))
    }
    
    
//  MARK: - PRIVATE AREA
    private func renewFreeHelp(_ gameHelp: GameHelpModel) async throws {
        
    }
    
}
