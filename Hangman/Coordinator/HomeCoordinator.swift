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
        var controller = makeHomeViewController()
        controller = navigationController.pushViewController(controller)
    }
    
 
    private func makeHomeViewController() -> HomeViewController {
        let homePresenter = HomePresenterImpl()
        return HomeViewController(homePresenter: homePresenter)
    }
    
}
