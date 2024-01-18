//  Created by Alessandro Comparini on 18/12/23.
//

import Foundation
import Domain
import Handler

public class HintsPresenterImpl: HintsPresenter {
    private var _delegateOutput: [HintsPresenterOutput]? = []
    
    private var lastHintsOpen: [Int]?
    
    public var delegateOutput: HintsPresenterOutput? {
        get { nil }
        set { if let newValue { _delegateOutput?.append(newValue) } }
    }
    
    deinit {
        _delegateOutput = nil
    }
    
    
    //  MARK: - INITIALIZERS
    
    public var dataTransfer: DataTransferHints?
    private let updateGameHelpUseCase: UpdateGameHelpUseCase
    private let getLastOpenHintsUseCase: GetLastOpenHintsUseCase
    
    public init(updateGameHelpUseCase: UpdateGameHelpUseCase, getLastOpenHintsUseCase: GetLastOpenHintsUseCase, dataTransfer: DataTransferHints?) {
        self.updateGameHelpUseCase = updateGameHelpUseCase
        self.dataTransfer = dataTransfer
        self.getLastOpenHintsUseCase = getLastOpenHintsUseCase
        configure()
    }
    
    
    //  MARK: - PUBLIC AREA
    
    public func openHint(indexHint: Int?) {
        guard var count = dataTransfer?.gameHelpPresenterDTO?.hintsCount else { return }
        
        if count == 0 { return hintIsOver() }
        
        count -= 1
        
        dataTransfer?.gameHelpPresenterDTO?.hintsCount = count
        
        updateGameHelp(GameHelpModel(typeGameHelp: TypeGameHelpModel(hints: count)))
        
        revealHintsCompleted(count)
        
        if let indexHint {
            saveHintOpen(indexHint)
        }
    }
    
    public func getLastHintsOpen() -> [Int] { lastHintsOpen ?? []}
    
    private func fetchLastHintsOpen() {
        if let userID = dataTransfer?.userID {
            Task {
                do {
                    lastHintsOpen = try await getLastOpenHintsUseCase.get(userID)
                } catch let error {
                    debugPrint(#function, error.localizedDescription)
                }
                getLastHintsOpenSuccess()
            }
        }
    }
    
    private func saveHintOpen(_ index: Int) {
        print("BOOOORAAAA GRAVAR", index)
    }
    
    public func numberOfItemsCallback() -> Int { dataTransfer?.wordPresenterDTO?.hints?.count ?? 0  }
    
    public func getHintByIndex(_ index: Int) -> String { dataTransfer?.wordPresenterDTO?.hints?[index] ?? "" }
    
    public func verifyHintIsOver() {
        guard let count = dataTransfer?.gameHelpPresenterDTO?.hintsCount else { return }
        
        if count > 0 { return }
        
        hintIsOver()
    }
    
    
    
    //  MARK: - PRIVATE AREA
    private func configure() {
        fetchLastHintsOpen()
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
                $0.hintIsOver()
            })
        }
    }
    
    private func getLastHintsOpenSuccess() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            _delegateOutput?.forEach({
                $0.getLastHintsOpen()
            })
        }
        
    }


    
}
