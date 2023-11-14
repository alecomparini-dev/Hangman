//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

public final class NavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func pushViewController<T>(_ viewController: UIViewController) -> T {
        if let controller = self.viewControllers.first(where: { $0.isKind(of: type(of: viewController))  }) {
            popToViewController(controller, animated: true)
            return controller as! T
        }
        pushViewController(viewController, animated: true)
        return viewController as! T
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
//  MARK: - PRIVATE AREA
    private func setup() {
        navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
}

