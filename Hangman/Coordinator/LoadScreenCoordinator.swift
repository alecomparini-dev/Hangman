//  Created by Alessandro Comparini on 31/10/23.
//

import Foundation


class LoadScreenCoordinator: Coordinator {
    var coordinator: Coordinator?
    unowned let navigationController: NavigationController
    
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinator = self
        var controller = LoadScreenViewController()
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
    }
    

}


//  MARK: - EXTENSION - LoadScreenViewControllerCoordinator
extension LoadScreenCoordinator: LoadScreenViewControllerCoordinator {
    func gotoSignIn() {
        let coordinator = HomeCoordinator(navigationController)
        coordinator.start()
        self.coordinator = nil
    }
    
}
