//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit

import CustomComponentsSDK

class TipsView: UIView {
    var cardsTipsHeightAnchor: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setGradient({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary, percentageGradient: 80)
                    .setAxialGradient(.rightBottomToLeftTop)
                    .apply(size: CurrentWindow.get?.frame.size ?? CGSize())
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var cardsTips: DockBuilder = {
        let comp = DockBuilder()
            .setBackgroundColor(.clear)
            .setCellsSize(CGSize(width: 140, height: 150))
            .setScrollDirection(.vertical)
            .setShowsVerticalScrollIndicator(false)
            .setMinimumInteritemSpacing(0)
            .setMinimumLineSpacing(25)
            .setPadding(top: 0, left: 10, bottom: 0, rigth: 10)
            .setBorder({ build in
                build
                    .setCornerRadius(24)
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(48)
                    .setLeading.setTrailing.equalToSafeArea(32)
            }
        return comp
    }()
    
    
//  MARK: - PUBLIC AREA
    
    public func configCardsTips() {
        configCardsTipsHeightAnchor()
    }
    
    private func configCardsTipsHeightAnchor() {
        cardsTipsHeightAnchor?.constant = frame.height - 72
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        cardsTips.add(insideTo: self)
    }

    private func configConstraints() {
        backgroundView.applyConstraint()
        configCardsTipsContraints()
    }
    
    private func configCardsTipsContraints() {
        cardsTips.applyConstraint()
        cardsTipsHeightAnchor = cardsTips.get.heightAnchor.constraint(equalToConstant: 300)
        cardsTipsHeightAnchor?.isActive = true
    }
    
}
