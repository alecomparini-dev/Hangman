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
        
        let countHints = countHintsHelp(gameHelp.hints)
        let countLives = countLivesHelp(gameHelp.lives)
        let countRevelations = countRevelationsHelp(gameHelp.revelations)
        
        return FetchGameHelpUseCaseDTO(livesCount: countLives, hintsCount: countHints, revelationsCount: countRevelations)
    }
    
    
//  MARK: - PRIVATE AREA
    private func renewFreeHelp(_ gameHelp: GameHelpModel) async throws {
        
    }
    
    private func countHintsHelp(_ hints: HintsGameHelpModel?) -> Int {
        guard let hints else { return 0 }
        return hints.adHints + hints.freeHints
    }
    
    private func countLivesHelp(_ lives: LivesGameHelpModel?) -> Int {
        guard let lives else { return 0 }
        return lives.adLives + lives.freeLives + lives.buyLives
    }
    
    private func countRevelationsHelp(_ revelations: RevelationsGameHelpModel?) -> Int {
        guard let revelations else { return 0 }
        return revelations.adRevelations + revelations.freeRevelations + revelations.buyRevelations
    }
    
    
}
