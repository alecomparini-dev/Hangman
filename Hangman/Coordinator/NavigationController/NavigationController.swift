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
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: kCATransition)
        
        pushViewController(viewController, animated: false)
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

