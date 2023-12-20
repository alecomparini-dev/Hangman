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
            .setBackgroundColor(Theme.shared.currentTheme.secondary.adjustBrightness(50))
            .setGradient({ build in
                build
//                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                    .setAxialGradient(.leftTopToRightBottom)
//                    .setAxialGradient(.rightBottomToLeftTop)
                    .setReferenceColor(Theme.shared.currentTheme.secondary, percentageGradient: 80)
//                    .apply(size: CurrentWindow.get?.frame.size ?? CGSize())
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var upDownButton: ImageViewBuilder = {
        let img = UIImage(systemName: "chevron.down")
        let comp = ImageViewBuilder(img)
            .setTintColor(Theme.shared.currentTheme.onSecondary)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setTop.setTrailing.equalToSafeArea(16)
                    .setSize.equalToConstant(40)
            }
        return comp
    }()

    
    lazy var cardsTipsDock: DockBuilder = {
        let comp = DockBuilder()
            .setBackgroundColor(.clear)
            .setDisableUserInteraction(true)
            .setCellsSize(CGSize(width: 330, height: 100))
            .setScrollDirection(.vertical)
            .setShowsVerticalScrollIndicator(false)
            .setMinimumInteritemSpacing(0)
            .setMinimumLineSpacing(16)
            .setContentInset(top: 0, left: 0, bottom: 48, rigth: 0)
            .setPadding(top: 0, left: 0, bottom: 0, rigth: 0)
            .setBorder({ build in
                build
                    .setCornerRadius(24)
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(80)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setBottom.equalToSuperView
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        configBlur()
    }

    private func addElements() {
        backgroundView.add(insideTo: self)
        upDownButton.add(insideTo: self)
        cardsTipsDock.add(insideTo: self)
    }

    private func configConstraints() {
        backgroundView.applyConstraint()
        upDownButton.applyConstraint()
        cardsTipsDock.applyConstraint()
    }
    
    private func configBlur() {
        BlurBuilder(cardsTipsDock.get, style: .systemUltraThinMaterialDark)
            .apply()
    }
    
    
}
