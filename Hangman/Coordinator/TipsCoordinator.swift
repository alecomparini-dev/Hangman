//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import Detail
import CustomComponentsSDK

class TipsCoordinator: NSObject, Coordinator {
    var childCoordinator: Coordinator?
    unowned var navigationController: NavigationController
    var dataTransfer: Any?
    
    required init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinator = self
        let controller = TipsViewController()
        controller.setDataTransfer(dataTransfer)
        controller.coordinator = self
        
        guard let currentScene = CurrentWindow.get else { return }
        let rootController = currentScene.rootViewController
//        controller.modalPresentationStyle = .custom
//        controller.transitioningDelegate = self
        rootController?.present(controller, animated: true)
    }
    
    
}


//  MARK: - EXTENSIO - TipsViewControllerCoordinator
extension TipsCoordinator: TipsViewControllerCoordinator {
    
}


//class CustomPresentationController: UISheetPresentationController {
//    var customHeight: CGFloat = 0.3
//
//    override var frameOfPresentedViewInContainerView: CGRect {
//        guard let containerView = containerView else { return CGRect.zero }
//
//        // Defina a altura desejada (por exemplo, 70% da altura da tela)
//        let desiredHeight = containerView.bounds.height * customHeight
//
//        return CGRect(x: 0, y: containerView.bounds.height - desiredHeight, width: containerView.bounds.width, height: desiredHeight)
//    }
//}
//
//
//@available(iOS 15.0, *)
//extension TipsCoordinator: UIViewControllerTransitioningDelegate {
//    
//    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting)
//        return presentationController
//    }
//}
//
//
