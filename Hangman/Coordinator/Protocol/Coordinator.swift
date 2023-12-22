//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinator: Coordinator? { get set }
    
    var navigationController: NavigationController { get }
    
    var dataTransfer: Any? { get set }
    
    init(_ navigationController: NavigationController)
    
    func start()

}

