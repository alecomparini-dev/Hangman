//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK
import Presenter

public protocol TipsViewControllerCoordinator: AnyObject {

}


public class TipsViewController: UIViewController {
    public weak var coordinator: TipsViewControllerCoordinator?
    
    private var word: WordPresenterDTO?
    
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
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let word = data as? WordPresenterDTO {
            self.word = word
            screen.cardsTipsDock.reload()
        }
    }
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configCardTipsShow()
        configBottomSheet()
    }
    
    private func configDelegate() {
        screen.cardsTipsDock.setDelegate(self)
    }

    private func configCardTipsShow() {
        screen.cardsTipsDock.show()
    }

    private func configBottomSheet() {
        self.setBottomSheet({ build in
            build
                .setDelegate(self)
                .setDetents([.medium, .large])
                .setCornerRadius(24)
                .setGrabbervisible(true)
                .setScrollingExpandsWhenScrolledToEdge(false)
        })
    }

}


//  MARK: - EXTENSION - UISheetPresentationControllerDelegate
extension TipsViewController: UISheetPresentationControllerDelegate {
    
    @available(iOS 15.0, *)
    public func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            return
        }
    }
    
}


//  MARK: - EXTENSION - DockDelegate
extension TipsViewController: DockDelegate {
    public func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int {
        return word?.tips?.count ?? 0
    }
    
    public func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView {
        return CardTipsViewCell(word?.tips?[index] ?? "")
    }
    
    public func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        return nil
    }
    
}
