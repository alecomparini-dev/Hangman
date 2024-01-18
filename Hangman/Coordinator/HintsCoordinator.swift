//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import Detail
import CustomComponentsSDK
import Presenter

class HintsCoordinator: NSObject, Coordinator {
    var coordinator: Coordinator?
    
    unowned var navigationController: NavigationController
    var dataTransfer: DataTransferHints?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinator = self
        let controller = HintsViewControllerFactory.make(dataTransfer)
        controller.coordinator = self
        
        guard let currentScene = CurrentWindow.get else { return }
        let rootController = currentScene.rootViewController
        rootController?.present(controller, animated: true)
    }
    
    
}


//  MARK: - EXTENSIO - HintsViewControllerCoordinator
extension HintsCoordinator: HintsViewControllerCoordinator {
    func gotoHome(_ vc: UIViewController) {
        vc.dismiss(animated: true)
    }
    
    
    func freeMemoryCoordinator() {
        coordinator = nil
    }
}
