//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation
import Presenter

class HintsPresenterOutputMock: HintsPresenterOutput {
    private var _completionHintsIsOver: (() -> Void)?
    private var _completionRevealHintsCompleted: ((Int) -> Void)?
    private var _completionSaveLastHintsOpen: (([Int]) -> Void)?
    
    func completionHintsIsOver(_ completion: @escaping () -> Void) { _completionHintsIsOver = completion }
    func completionRevealHintsCompleted(_ completion: @escaping (Int) -> Void) { _completionRevealHintsCompleted = completion }
    func completionSaveLastHintsOpen(_ completion: @escaping ([Int]) -> Void) { _completionSaveLastHintsOpen = completion }
    
    var isMainThread = false
    
    func hintsIsOver() {
        verifyMainThread()
        _completionHintsIsOver?()
    }
    
    func revealHintsCompleted(_ count: Int) {
        verifyMainThread()
        _completionRevealHintsCompleted?(count)
    }
    
    func saveLastHintsOpen(_ indexes: [Int]) {
        verifyMainThread()
        _completionSaveLastHintsOpen?(indexes)
    }
    
    private func verifyMainThread() {
        if Thread.isMainThread {
            isMainThread = true
        }
    }
    
}
