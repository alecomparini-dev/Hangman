//  Created by Alessandro Comparini on 18/12/23.
//

import Foundation
import Domain
import Handler

public class HintsPresenterImpl: HintsPresenter {
    public var delegateOutput: HintsPresenterOutput?
    
    
//  MARK: - INITIALIZERS
    
    public var dataTransfer: DataTransferHintsVC?
    private let updateGameHelpUseCase: UpdateGameHelpUseCase
    
    public init(updateGameHelpUseCase: UpdateGameHelpUseCase, dataTransfer: DataTransferHintsVC?) {
        self.updateGameHelpUseCase = updateGameHelpUseCase
        self.dataTransfer = dataTransfer
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func revealHint() {
        if var count = dataTransfer?.gameHelpPresenterDTO?.hintsCount {
            count -= 1
            dataTransfer?.gameHelpPresenterDTO?.hintsCount = count
            updateGameHelp(GameHelpModel(typeGameHelp: TypeGameHelpModel(hints: count)))
            revealHintsCompleted(count)
        }
    }
    
    public func saveHintOpen(_ index: Int) {
        
    }
    
    public func numberOfItemsCallback() -> Int { dataTransfer?.wordPresenterDTO?.hints?.count ?? 0  }
    
    public func getHint(_ index: Int) -> String { dataTransfer?.wordPresenterDTO?.hints?[index] ?? "" }
    
    
//  MARK: - PRIVATE AREA
    private func updateGameHelp(_ gameHelpModel: GameHelpModel) {
        guard let userID = dataTransfer?.userID else { return }
        Task {
            do {
                try await updateGameHelpUseCase.update(userID, gameHelp: gameHelpModel)
            } catch let error {
                debugPrint(#function, error.localizedDescription)
            }
        }
    }
    
    
//  MARK: - PRIVATE OUTPUT AREA
    
    private func revealHintsCompleted(_ count: Int) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.revealHintsCompleted(count)
        }
    }

    
}
