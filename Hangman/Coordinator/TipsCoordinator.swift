//  Created by Alessandro Comparini on 13/12/23.
//

import Foundation
import Detail
import CustomComponentsSDK

class TipsCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        let controller = TipsViewController()
        controller.coordinator = self
        
        guard let currentScene = CurrentWindow.get else { return }
        let rootController = currentScene.rootViewController

        if #available(iOS 15.0, *) {
            controller.setBottomSheet({ build in
                build
                    .setDetents([.medium, .large])
                    .setCornerRadius(24)
                    .setGrabbervisible(true)
                    .setScrollingExpandsWhenScrolledToEdge(false)
            })
        }
        
        rootController?.present(controller, animated: true)
    }
    
    
}


//  MARK: - EXTENSIO - TipsViewControllerCoordinator
extension TipsCoordinator: TipsViewControllerCoordinator {
    
}
