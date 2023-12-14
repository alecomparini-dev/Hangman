//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit

public protocol TipsViewControllerCoordinator: AnyObject {
    
}


public class TipsViewController: UIViewController {
    public weak var coordinator: TipsViewControllerCoordinator?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: TipsView = {
        let comp = TipsView()
        return comp
    }()
    
    
//  MARK: - LIFE CICLE
    
    public override func loadView() {
        view = screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    
}
