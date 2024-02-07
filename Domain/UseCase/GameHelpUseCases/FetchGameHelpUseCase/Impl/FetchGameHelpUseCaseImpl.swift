//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Handler

public class FetchGameHelpUseCaseImpl: FetchGameHelpUseCase {
    
    private let fetchGameHelpGateway: FetchGameHelpUseCaseGateway
    private let saveGameHelpGateway: SaveGameHelpUseCaseGateway
    private let maxGameHelpUseCase: MaxGameHelpUseCase
    
    public init(fetchGameHelpGateway: FetchGameHelpUseCaseGateway, saveGameHelpGateway: SaveGameHelpUseCaseGateway, maxGameHelpUseCase: MaxGameHelpUseCase) {
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
                renewGameHelp = calculateRenew(renewGameHelp)
                try await saveGameHelpGateway.save(userID, gameHelp: renewGameHelp)
            }
        }
        return renewGameHelp
    }
    
    private func calculateRenew(_ renewGameHelp: GameHelpModel) -> GameHelpModel {
        var gameHelp = renewGameHelp
        
        if (gameHelp.typeGameHelp?.lives ?? 0) < maxGameHelpUseCase.max(typeGameHelp: .lives) {
            gameHelp.typeGameHelp?.lives = maxGameHelpUseCase.max(typeGameHelp: .lives)
        }
        
        if (gameHelp.typeGameHelp?.hints ?? 0) < maxGameHelpUseCase.max(typeGameHelp: .hints) {
            gameHelp.typeGameHelp?.hints = maxGameHelpUseCase.max(typeGameHelp: .hints)
        }
        
        if (gameHelp.typeGameHelp?.revelations ?? 0) < maxGameHelpUseCase.max(typeGameHelp: .revelations) {
            gameHelp.typeGameHelp?.revelations = maxGameHelpUseCase.max(typeGameHelp: .revelations)
        }
        
        return gameHelp
    }
    
    private func makeFetchGameHelpUseCaseDTO(_ gameHelp: GameHelpModel?) -> FetchGameHelpUseCaseDTO? {
        return FetchGameHelpUseCaseDTO(
            livesCount: gameHelp?.typeGameHelp?.lives,
            hintsCount: gameHelp?.typeGameHelp?.hints,
            revelationsCount: gameHelp?.typeGameHelp?.revelations
        )
    }
    
}
