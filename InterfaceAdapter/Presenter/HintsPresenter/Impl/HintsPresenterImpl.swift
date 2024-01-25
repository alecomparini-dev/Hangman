//  Created by Alessandro Comparini on 18/12/23.
//

import Foundation
import Domain
import Handler

public class HintsPresenterImpl: HintsPresenter {
    private var _delegateOutput: [HintsPresenterOutput]? = []
    
    public var delegateOutput: HintsPresenterOutput? {
        get { nil }
        set { if let newValue { _delegateOutput?.append(newValue) } }
    }
    
    deinit {
        _delegateOutput = nil
    }
    
    
    //  MARK: - INITIALIZERS
    
    private let updateGameHelpUseCase: UpdateGameHelpUseCase
    private let saveLastOpenHintsUseCase: SaveLastOpenHintsUseCase
    public var dataTransfer: DataTransferHints?
    
    
    public init(updateGameHelpUseCase: UpdateGameHelpUseCase, 
                saveLastOpenHintsUseCase: SaveLastOpenHintsUseCase,
                dataTransfer: DataTransferHints? = nil) {
        self.updateGameHelpUseCase = updateGameHelpUseCase
        self.saveLastOpenHintsUseCase = saveLastOpenHintsUseCase
        self.dataTransfer = dataTransfer
        configure()
    }
    
    
    //  MARK: - PUBLIC AREA
    
    public func openHint(indexHint: Int?) {
        guard var count = dataTransfer?.gameHelpPresenterDTO?.hintsCount else { return }
        
        if count == 0 { return hintIsOver() }
        
        do {
            try saveHintsOpen(indexHint)
            count -= 1
            dataTransfer?.gameHelpPresenterDTO?.hintsCount = count
        } catch  let error {
            debugPrint(#function, error.localizedDescription)
        }
        
        updateGameHelp(GameHelpModel(typeGameHelp: TypeGameHelpModel(hints: count)))
        
        revealHintsCompleted(count)
        
        verifyHintIsOver()
    }
    
    public func getLastHintsOpen() -> [Int] { dataTransfer?.lastHintsOpen ?? []}
    
    public func numberOfItemsCallback() -> Int { dataTransfer?.wordPresenterDTO?.hints?.count ?? 0  }
    
    public func getHintByIndex(_ index: Int) -> String { dataTransfer?.wordPresenterDTO?.hints?[index] ?? "" }
    
    public func verifyHintIsOver() {
        guard let count = dataTransfer?.gameHelpPresenterDTO?.hintsCount else { return }
        
        if count > 0 { return }
        
        hintIsOver()
    }
    
    
    
    //  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
    }
    
    private func configDelegate() {
        delegateOutput = dataTransfer?.delegate
    }
    
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
    
    private func saveHintsOpen(_ index: Int?) throws {
        guard let index, let userID = dataTransfer?.userID else { return }
        dataTransfer?.lastHintsOpen?.append(index)
        if let indexes = dataTransfer?.lastHintsOpen {
            Task {
                try await saveLastOpenHintsUseCase.save(userID, indexes)
                saveLastHintsOpen(indexes)
            }
        }
        
    }
    
    
    //  MARK: - PRIVATE OUTPUT AREA
    
    private func revealHintsCompleted(_ count: Int) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            _delegateOutput?.forEach({
                $0.revealHintsCompleted(count)
            })
        }
    }
    
    private func hintIsOver() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            _delegateOutput?.forEach({
                $0.hintsIsOver()
            })
        }
    }
    
    private func saveLastHintsOpen(_ indexes: [Int]) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            _delegateOutput?.forEach({
                $0.saveLastHintsOpen(indexes)
            })
        }
    }
    

    
}
