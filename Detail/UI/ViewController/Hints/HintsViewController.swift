//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler
import Presenter

public protocol HintsViewControllerCoordinator: AnyObject {
    func freeMemoryCoordinator()
    func gotoHome(_ vc: UIViewController)
}


public class HintsViewController: UIViewController {
    public weak var coordinator: HintsViewControllerCoordinator?
    
    private var dataTransfer: DataTransferHintsVC?
    private var word: WordPresenterDTO?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: HintsView = {
        let comp = HintsView()
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
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.freeMemoryCoordinator()
    }
    
    
//  MARK: - DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let data = data as? DataTransferHintsVC {
            dataTransfer = data
            word = data.wordPresenterDTO
            screen.cardsHintsDock.reload()
        }
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configCardHintsDockShow()
        configBottomSheet()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.cardsHintsDock.setDelegate(self)
    }

    private func configCardHintsDockShow() {
        screen.cardsHintsDock.show()
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
    
    private func setOpenedTipViewCell(_ card: CardHintsViewCell) {
        card.imageTip.setImage(systemName: K.Images.hint)
        
        card.lockedImageTip.setHidden(true)
        
        configStyleTipImageView(card.tipImageView)
        
        hideBlurAnimation(card.blurHideTip.get)
        
        minusOneLabelAnimation(card.minusOneLabel.get)
        
        decreaseHintsAndUpdateHome()
    }
    
    private func configStyleTipImageView(_ tipImageView: ViewBuilder) {
        tipImageView.get.removeNeumorphism()
        tipImageView.setBackgroundColor(Theme.shared.currentTheme.secondary)
        configBorderTipImageView(tipImageView)
        configShadowOnTipImageView(tipImageView)
    }
    
    private func configBorderTipImageView(_ tipImageView: ViewBuilder) {
        tipImageView
            .setBorder { build in
                build
                    .setColor(Theme.shared.currentTheme.primary)
                    .setWidth(1)
            }
    }
    
    private func configShadowOnTipImageView(_ tipImageView: ViewBuilder) {
        let shadow = ShadowBuilder(tipImageView.get)
            .setColor(Theme.shared.currentTheme.primary)
            .setRadius(6)
            .setOffset(width: 0, height: 0)
            .setOpacity(1)
            .apply()
        
        let interaction = ButtonInteractionBuilder(component: tipImageView.get)
            .setShadowPressed(shadow)
        interaction.pressed
    }
    
    private func decreaseHintsAndUpdateHome() {
        if var hintsCount = dataTransfer?.gameHelpPresenterDTO?.hintsCount {
            hintsCount -= 1
            dataTransfer?.gameHelpPresenterDTO?.hintsCount = hintsCount
            if let completion = dataTransfer?.updateHintsCompletion {
                completion(hintsCount.description)
            }
        }
    }
    
    private func hideBlurAnimation(_ blurHideTip: UIView) {
        let x = blurHideTip.layer.frame.maxX
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseIn , animations: {
            blurHideTip.layer.frame.size.width = 0
            blurHideTip.layer.frame.origin.x = x
        })
    }
    
    private func minusOneLabelAnimation(_ minusOneLabel: UILabel) {
        minusOneLabel.alpha = 1
        let minusY = minusOneLabel.layer.frame.origin.y - 24
        let minusX = minusOneLabel.layer.frame.origin.x + 20
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut , animations: {
            minusOneLabel.layer.frame.origin.y = minusY
            minusOneLabel.layer.frame.origin.x = minusX
            minusOneLabel.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                minusOneLabel.transform = .identity
                minusOneLabel.alpha = 0
            }
        }
    }

}


//  MARK: - EXTENSION - HintsViewDelegate
extension HintsViewController: HintsViewDelegate {
    
    func downButtonTapped() {
        coordinator?.gotoHome(self)
    }
    
    
}


//  MARK: - EXTENSION - UISheetPresentationControllerDelegate
extension HintsViewController: UISheetPresentationControllerDelegate {
    
    @available(iOS 15.0, *)
    public func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if sheetPresentationController.selectedDetentIdentifier == .medium {
            return
        }
    }
    
}


//  MARK: - EXTENSION - DockDelegate
extension HintsViewController: DockDelegate {
    public func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int {
        return word?.hints?.count ?? 0
    }
    
    public func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView {
        let cardHintsViewCell = CardHintsViewCell(word?.hints?[index] ?? "")
        cardHintsViewCell.delegate = self
        return cardHintsViewCell
    }
    
    public func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        return nil
    }
    
}

//  MARK: - EXTENSION - CardHintsViewCellDelegate
extension HintsViewController: CardHintsViewCellDelegate {
    
    func openHints(_ cardHitsViewCell: CardHintsViewCell) {
        setOpenedTipViewCell(cardHitsViewCell)
    }
    
    
}
