//  Created by Alessandro Comparini on 17/01/24.
//

import Foundation
import Domain
import Handler

public class GameHelpPresenterImpl: GameHelpPresenter {
    public var delegateOutput: GameHelpPresenterOutput?
    
    private var gameHelpPresenterDTO: GameHelpPresenterDTO?
    
    
//  MARK: - INITIALIZERS
    
    private let fetchGameHelpUseCase: FetchGameHelpUseCase
    private let maxGameHelpUseCase: MaxGameHelpUseCase
    private let updateGameHelpUseCase: UpdateGameHelpUseCase
    
    public init(fetchGameHelpUseCase: FetchGameHelpUseCase, maxGameHelpUseCase: MaxGameHelpUseCase, updateGameHelpUseCase: UpdateGameHelpUseCase) {
        self.fetchGameHelpUseCase = fetchGameHelpUseCase
        self.maxGameHelpUseCase = maxGameHelpUseCase
        self.updateGameHelpUseCase = updateGameHelpUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func maxHelp(_ typeGameHelp: TypeGameHelp) -> Int {
        switch typeGameHelp {
            case .lives:
                return maxGameHelpUseCase.max(typeGameHelp: .lives)
            case .hints:
                return maxGameHelpUseCase.max(typeGameHelp: .hints)
            case .revelations:
                return maxGameHelpUseCase.max(typeGameHelp: .revelations)
        }
    }
    
    public func update(_ userID: String, _ gameHelpModel: GameHelpModel) {
        Task {
            do {
                try await updateGameHelpUseCase.update(userID, gameHelp: gameHelpModel)
                updateGameHelpSuccess()
            } catch let error {
                debugPrint(#function, error.localizedDescription)
                fetchGameHelpError("Ops", "Não foi possível atualizar. Favor tente novamente mais tarde")
            }
        }
    }

    public func fetch(_ userID: String) {
        Task {
            do {
                let fetchGameHelpDTO = try await fetchGameHelpUseCase.fetch(userID)
                gameHelpPresenterDTO = GameHelpPresenterDTO(livesCount: fetchGameHelpDTO?.livesCount ?? 0,
                                                            hintsCount: fetchGameHelpDTO?.hintsCount ?? 0,
                                                            revelationsCount: fetchGameHelpDTO?.revelationsCount ?? 0)
                fetchGameHelpSuccess(gameHelpPresenterDTO)
            } catch let error {
                debugPrint(#function, error.localizedDescription)
                fetchGameHelpError("Ops", "Não foi possível recuperar suas ajudas. Favor tente novamente mais tarde")
            }
        }
        
    }

    
//  MARK: - PRIVATE OUTPUT AREA
    
    private func fetchGameHelpSuccess(_ gameHelpPresenterDTO: GameHelpPresenterDTO?) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.fetchGameHelpSuccess(gameHelpPresenterDTO)
        }
    }

    private func fetchGameHelpError(_ title: String, _ message: String) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.fetchGameHelpError(title: title, message: message)
        }
    }

    private func updateGameHelpSuccess() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateGameHelpSuccess()
        }
    }

    private func updateGameHelpError(_ title: String, _ message: String) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateGameHelpError(title: title, message: message)
        }
    }
    
    
}
