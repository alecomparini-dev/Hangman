//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

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
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        screen.configCardsTips()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configCardTipsShow()
    }
    
    private func configDelegate() {
        configBottomSheetDelegate()
        configCardTipsDelegate()
    }
    
    private func configBottomSheetDelegate() {
        if #available(iOS 15.0, *) {
            if let sheet = self.sheetPresentationController {
                sheet.delegate = self
            }
        }
    }
    
    private func configCardTipsDelegate() {
        screen.cardsTips.setDelegate(self)
    }
    
    private func configCardTipsShow() {
        screen.cardsTips.show()
    }
}


//  MARK: - EXTENSION - UISheetPresentationControllerDelegate
extension TipsViewController: UISheetPresentationControllerDelegate {
    
    @available(iOS 15.0, *)
    public func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            print("diminiuiu")
            return
        }
        print("ficou grandao")
        
    }
    
}


//  MARK: - EXTENSION - DockDelegate
extension TipsViewController: DockDelegate {
    public func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int {
        return 6
    }
    
    public func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView {
        return ViewBuilder()
            .setBorder { build in
                build
                    .setCornerRadius(12)
                    .setColor(.black)
                    .setWidth(1)
            }
            .get
    }
    
    public func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        return ViewBuilder()
            .setBorder { build in
                build
                    .setCornerRadius(12)
                    .setColor(.black)
                    .setWidth(1)
            }
            .setBackgroundColor(.yellow)
            .get
    }
    
}
