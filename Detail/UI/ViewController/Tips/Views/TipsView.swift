//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler

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
//            .setBackgroundColor(Theme.shared.currentTheme.secondary.adjustBrightness(50))
            .setGradient({ build in
                build
//                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
//                    .setAxialGradient(.leftTopToRightBottom)
//                    .setAxialGradient(.rightBottomToLeftTop)
                    .setAxialGradient(.rightToLeft)
                    .setReferenceColor(Theme.shared.currentTheme.secondary, percentageGradient: 80)
                    .apply(size: CurrentWindow.get?.frame.size ?? CGSize())
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()

    lazy var titleTipLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setTextAttributed({ build in
                build
                    .setText(text: "Selecione uma")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18, weight: .thin))
                    .setText(text: " dica")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 20, weight: .bold))
                    .setText(text: " para abrir")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18, weight: .thin))
            })
            .setColor(Theme.shared.currentTheme.onSecondary)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(30)
                    .setLeading.equalToSafeArea(24)
            }
        return comp
    }()
    
    lazy var downButton: ImageViewBuilder = {
        let img = UIImage(systemName: K.Images.downButton)
        let comp = ImageViewBuilder(img)
            .setTintColor(Theme.shared.currentTheme.onSecondary)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(titleTipLabel.get, -2)
                    .setTrailing.equalToSafeArea(-16)
                    .setSize.equalToConstant(40)
            }
        return comp
    }()

    lazy var cardsTipsDock: DockBuilder = {
        let comp = DockBuilder()
            .setBackgroundColor(.clear)
            .setDisableUserInteraction(true)
            .setCellsSize(CGSize(width: 345, height: 100))
            .setScrollDirection(.vertical)
            .setShowsVerticalScrollIndicator(false)
            .setMinimumLineSpacing(8)
            .setContentInset(top: 0, left: 0, bottom: 48, rigth: 0)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleTipLabel.get, .bottom, 16)
                    .setLeading.setTrailing.equalToSafeArea(16)
                    .setBottom.equalToSuperView
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }

    private func addElements() {
        backgroundView.add(insideTo: self)
        titleTipLabel.add(insideTo: self)
        downButton.add(insideTo: self)
        cardsTipsDock.add(insideTo: self)
    }

    private func configConstraints() {
        backgroundView.applyConstraint()
        titleTipLabel.applyConstraint()
        downButton.applyConstraint()
        cardsTipsDock.applyConstraint()
    }
    
    
}
