//  Created by Alessandro Comparini on 14/11/23.
//

import Foundation

import Detail
import Presenter


class HomeCoordinator: Coordinator {
    var coordinator: Coordinator?
    unowned let navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        coordinator = self
        var controller = HomeViewControllerFactory.make()
        controller.setDataTransfer(dataTransfer)
        controller = navigationController.pushViewController(controller)
        controller.coordinator = self
        removeLastViewController()
    }
 
    private func removeLastViewController() {
        navigationController.viewControllers = Array(navigationController.viewControllers.dropFirst(1))
    }
    
}


//  MARK: - EXTENSION - HomeViewControllerCoordinator

extension HomeCoordinator: HomeViewControllerCoordinator {
    
    func gotoHomeNextWord(_ dataTransfer: DataTransferHomeVC) {
        let homeCoordinator = HomeCoordinator(navigationController)
        homeCoordinator.dataTransfer = dataTransfer
        homeCoordinator.start()
        coordinator = nil
    }
    
    func gotoHints(_ dataTransfer: DataTransferHintsVC?) {
        let hintsCoordinator = HintsCoordinator(navigationController)
        hintsCoordinator.dataTransfer = dataTransfer
        hintsCoordinator.start()
    }
}
