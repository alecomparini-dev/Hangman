//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Handler

public class FetchGameHelpUseCaseImpl: FetchGameHelpUseCase {
    
    private let fetchGameHelpGateway: FetchGameHelpUseCaseGateway
    private let saveGameHelpGateway: SaveGameHelpUseCaseGateway
    private let maxGameHelpUseCase: MaxTypeGameHelpUseCase
    
    public init(fetchGameHelpGateway: FetchGameHelpUseCaseGateway, saveGameHelpGateway: SaveGameHelpUseCaseGateway, maxGameHelpUseCase: MaxTypeGameHelpUseCase) {
        self.fetchGameHelpGateway = fetchGameHelpGateway
        self.saveGameHelpGateway = saveGameHelpGateway
        self.maxGameHelpUseCase = maxGameHelpUseCase
    }
    
    public func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO? {
        var gameHelp: GameHelpModel? = try await fetchGameHelpGateway.fetch(userID)
        
        gameHelp = try await renewFreeHelp(userID, gameHelp)
        
        if gameHelp == nil {
            gameHelp = try await saveInitialGameHelp(userID)
        }
        
        return makeFetchGameHelpUseCaseDTO(gameHelp)
    }
    
    
//  MARK: - PRIVATE AREA
    private func saveInitialGameHelp(_ userID: String) async throws -> GameHelpModel {
        let gameHelp = GameHelpModel(
            dateRenewFree: .now,
            typeGameHelp: TypeGameHelpModel(
                lives: maxGameHelpUseCase.max(typeGameHelp: .lives),
                hints: maxGameHelpUseCase.max(typeGameHelp: .hints),
                revelations: maxGameHelpUseCase.max(typeGameHelp: .revelations))
        )
        
        try await saveGameHelpGateway.save(userID, gameHelp: gameHelp)
        
        return gameHelp
    }
    
    private func renewFreeHelp(_ userID: String, _ gameHelp: GameHelpModel?) async throws -> GameHelpModel? {
        guard var renewGameHelp = gameHelp else { return nil }
        let date = DateHandler.getCurrentDate()
        if let currentDate = DateHandler.convertDate("\(date.year)-\(date.month)-\(date.day)") {
            if let dateRenew = renewGameHelp.dateRenewFree, dateRenew < currentDate {
                renewGameHelp.dateRenewFree = .now
                renewGameHelp.typeGameHelp?.lives = maxGameHelpUseCase.max(typeGameHelp: .lives)
                renewGameHelp.typeGameHelp?.hints = maxGameHelpUseCase.max(typeGameHelp: .hints)
                renewGameHelp.typeGameHelp?.revelations = maxGameHelpUseCase.max(typeGameHelp: .revelations)
                try await saveGameHelpGateway.save(userID, gameHelp: renewGameHelp)
            }
        }
        return renewGameHelp
    }
    
    private func makeFetchGameHelpUseCaseDTO(_ gameHelp: GameHelpModel?) -> FetchGameHelpUseCaseDTO? {
        guard let gameHelp else { return nil }
        return FetchGameHelpUseCaseDTO(
            livesCount: gameHelp.typeGameHelp?.lives ?? 0,
            hintsCount: gameHelp.typeGameHelp?.hints ?? 0,
            revelationsCount: gameHelp.typeGameHelp?.revelations ?? 0
        )
    }
    
}
