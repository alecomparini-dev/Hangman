//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Handler

public class FetchGameHelpUseCaseImpl: FetchGameHelpUseCase {
    
    private let fetchGameHelpGateway: FetchGameHelpUseCaseGateway
    private let saveGameHelpGateway: SaveGameHelpUseCaseGateway
    
    public init(fetchGameHelpGateway: FetchGameHelpUseCaseGateway, saveGameHelpGateway: SaveGameHelpUseCaseGateway) {
        self.fetchGameHelpGateway = fetchGameHelpGateway
        self.saveGameHelpGateway = saveGameHelpGateway
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
                lives: LivesGameHelpModel(channel: makeChannel(MaxFreeHelps.lives)),
                hints: HintsGameHelpModel(channel: makeChannel(MaxFreeHelps.hints)),
                revelations: RevelationsGameHelpModel(channel: makeChannel(MaxFreeHelps.revelations))
            )
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
                renewGameHelp = calculateFreeHelp(renewGameHelp)
                try await saveGameHelpGateway.save(userID, gameHelp: renewGameHelp)
            }
        }
        return renewGameHelp
    }
    
    private func calculateFreeHelp(_ gameHelp: GameHelpModel) -> GameHelpModel {
        var calculateFreeGameHelp = gameHelp
        
        let livesCount = LivesTypeGameHelp().count(calculateFreeGameHelp.typeGameHelp?.lives?.channel)
        let hintsCount = HintsTypeGameHelp().count(calculateFreeGameHelp.typeGameHelp?.hints?.channel)
        let revelationsCount = RevelationsTypeGameHelp().count(calculateFreeGameHelp.typeGameHelp?.revelations?.channel)
        
        if let remainingLives = calculateFreeGameHelp.typeGameHelp?.lives?.channel.free {
            calculateFreeGameHelp.typeGameHelp?.lives?.channel.free = remainingLives + (MaxFreeHelps.lives - livesCount)
        }
        
        if let remainingHints = calculateFreeGameHelp.typeGameHelp?.hints?.channel.free {
            calculateFreeGameHelp.typeGameHelp?.hints?.channel.free = remainingHints + (MaxFreeHelps.hints - hintsCount)
        }
         
        if let remainingRevelations = calculateFreeGameHelp.typeGameHelp?.revelations?.channel.free {
            calculateFreeGameHelp.typeGameHelp?.revelations?.channel.free = remainingRevelations + (MaxFreeHelps.revelations - revelationsCount)
        }
        
        return calculateFreeGameHelp
    }
    
    private func makeChannel(_ free: Int) -> ChannelGameHelpModel {
        return ChannelGameHelpModel(free: free, advertising: 0, buy: 0)
    }
    
    private func makeFetchGameHelpUseCaseDTO(_ gameHelp: GameHelpModel?) -> FetchGameHelpUseCaseDTO? {
        guard let gameHelp else { return nil }
        return FetchGameHelpUseCaseDTO(
            livesCount: LivesTypeGameHelp().count(gameHelp.typeGameHelp?.lives?.channel),
            hintsCount: HintsTypeGameHelp().count(gameHelp.typeGameHelp?.hints?.channel),
            revelationsCount: RevelationsTypeGameHelp().count(gameHelp.typeGameHelp?.revelations?.channel))
    }
    
}
