//  Created by Alessandro Comparini on 14/11/23.
//

import Foundation

import Detail
import Presenter


class HomeCoordinator: Coordinator {
    var childCoordinator: Coordinator?
    unowned let navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        var controller = HomeViewControllerFactory.make()
        controller.setDataTransfer(dataTransfer)
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
        removeLastViewController()
    }
 
    private func removeLastViewController() {
        navigationController.viewControllers = Array(navigationController.viewControllers.dropFirst(navigationController.viewControllers.count - 1))
    }
    
}


//  MARK: - EXTENSION - HomeViewControllerCoordinator

extension HomeCoordinator: HomeViewControllerCoordinator {
    
    func gotoHomeNextWord(_ dataTransfer: DataTransferDTO) {
        let coordinator = HomeCoordinator(navigationController)
        coordinator.dataTransfer = dataTransfer
        coordinator.start()
        childCoordinator = nil
    }
    
    func gotoTips(_ word: WordPresenterDTO?) {
        let coordinator = TipsCoordinator(navigationController)
        coordinator.dataTransfer = word
        coordinator.start()
    }
}
