//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: Coordinator? { get set }
    
    var navigationController: NavigationController { get }
    
    init(_ navigationController: NavigationController)
    
    func start()

}

