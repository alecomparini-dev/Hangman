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
    
    private var lastHintsOpen: [Int] = []
    private var card: CardHintsViewCell?
    
    
//  MARK: - INITIALIZERS
    private var hintsPresenter: HintsPresenter
    
    public init(hintsPresenter: HintsPresenter) {
        self.hintsPresenter = hintsPresenter
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
        hintsPresenter.verifyHintIsOver()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.freeMemoryCoordinator()
    }
        
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()
        configBottomSheet()
        screen.cardsHintsDock.show()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.cardsHintsDock.setDelegate(self)
        hintsPresenter.delegateOutput = self
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
        markCardHintsViewCellAsOpen(card)
        minusOneLabelAnimation(card.minusOneLabel.get)
        hideBlurAnimation(card.blurHideTip.get)
    }
    
    private func markCardHintsViewCellAsOpen(_ card: CardHintsViewCell) {
        card.imageHint.setImage(systemName: K.Images.hint)
        card.lockedImageHint.setHidden(true)
        configStyleHintImageView(card.hintImageView)
    }
    
    private func configStyleHintImageView(_ tipImageView: ViewBuilder) {
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


//  MARK: - EXTENSION - UISheetPresentationControllerDelegate
extension HintsViewController: HintsPresenterOutput {
    
    public func hintIsOver() {
        print("criar tela para quando terminar as dicas ")
    }
    

    public func revealHintsCompleted(_ count: Int, _ index: Int) {
        guard let card else { return }
        setOpenedTipViewCell(card)
    }
   
}


//  MARK: - EXTENSION - DockDelegate
extension HintsViewController: DockDelegate {
    
    public func numberOfItemsCallback(_ dockBuilder: DockBuilder) -> Int {
        return hintsPresenter.numberOfItemsCallback()
    }
    
    public func cellCallback(_ dockBuilder: DockBuilder, _ index: Int) -> UIView {
        let cardHintsViewCell = CardHintsViewCell(hintsPresenter.getHintByIndex(index))
        cardHintsViewCell.setTag(index)
        cardHintsViewCell.delegate = self
        
        if hintsPresenter.getLastHintsOpen().contains(index) {
            cardHintsViewCell.blurHideTip.setHidden(true)
            DispatchQueue.main.async { [weak self] in
                self?.markCardHintsViewCellAsOpen(cardHintsViewCell)
            }
        }
        
        return cardHintsViewCell
    }
    
    public func customCellActiveCallback(_ dockBuilder: DockBuilder, _ cell: UIView) -> UIView? {
        return nil
    }
    
    
}

//  MARK: - EXTENSION - CardHintsViewCellDelegate
extension HintsViewController: CardHintsViewCellDelegate {
    
    func openHints(_ cardHintsViewCell: CardHintsViewCell) {
        card = cardHintsViewCell
        hintsPresenter.openHint(indexHint: card?.tag)
    }
    
    
}
