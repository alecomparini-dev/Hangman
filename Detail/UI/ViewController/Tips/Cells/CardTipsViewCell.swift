//  Created by Alessandro Comparini on 18/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler
import Presenter

protocol CardTipsViewCellDelegate: AnyObject {
    func openTip(_ cardTipsViewCell: CardTipsViewCell)
}

class CardTipsViewCell: UIView {
    weak var delegate: CardTipsViewCellDelegate?
    
    private let word: String
    
    init(_ word: String) {
        self.word = word
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.secondary.adjustBrightness(74))
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSafeArea(4)
                    .setLeading.setTrailing.equalToSafeArea
            }
        return comp
    }()
    
    lazy var tipImageView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(25)
            })
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary.adjustBrightness(60))
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 100)
                    .setIntensity(to: .dark, percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setLeading.equalTo(backgroundView.get, .leading, 8)
                    .setWidth.equalToConstant(50)
                    .setHeight.equalToConstant(50)
            }
            .setActions { build in
                build
                    .setTap ({ [weak self] component, tapGesture in
                        guard let self else {return}
                        delegate?.openTip(self)
                    })
            }
        return comp
    }()
    
    lazy var imageTip: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.tipClose)
            .setTintColor(Theme.shared.currentTheme.onSecondary.withAlphaComponent(0.8))
            .setContentMode(.scaleAspectFit)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(tipImageView.get, 2)
                    .setHorizontalAlignmentX.equalTo(tipImageView.get, -1)
                    .setSize.equalToConstant(26)
            }
        return comp
    }()
    
    lazy var lockedImageTip: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.tipLocked)
            .setTintColor(Theme.shared.currentTheme.onSecondary)
            .setContentMode(.scaleAspectFit)
            .setConstraints { build in
                build
                    .setTrailing.equalTo(imageTip.get, .trailing, 2)
                    .setBottom.equalTo(imageTip.get, .bottom)
                    .setSize.equalToConstant(16)
            }
        return comp
    }()
    
    lazy var tipLabel: LabelBuilder = {
        let comp = LabelBuilder(word)
            .setColor(.white)
            .setWeight(.bold)
            .setSize(15)
            .setNumberOfLines(3)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setLeading.equalTo(tipImageView.get, .trailing, 12)
                    .setTrailing.equalToSafeArea(-16)
            }
        return comp
    }()

    lazy var blurHideTip: BlurBuilder = {
        let comp = BlurBuilder(style: .regular)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.setTrailing.setBottom.equalTo(backgroundView.get, 16)
                    .setLeading.equalTo(tipLabel.get, .leading)
            }
            .setActions { build in
                build
                    .setTap ({ [weak self] component, tapGesture in
                        guard let self else {return}
                        delegate?.openTip(self)
                    })
            }
        return comp
    }()
    
    lazy var minusOneLabel: LabelBuilder = {
        let comp = LabelBuilder("-1")
            .setAlpha(0)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setWeight(.semibold)
            .setSize(18)
            .setConstraints { build in
                build
                    .setTop.setTrailing.equalTo(tipImageView.get)
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
        tipImageView.add(insideTo: self)
        imageTip.add(insideTo: tipImageView.get)
        lockedImageTip.add(insideTo: tipImageView.get)
        tipLabel.add(insideTo: self)
        blurHideTip.add(insideTo: self)
        minusOneLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        tipImageView.applyConstraint()
        imageTip.applyConstraint()
        lockedImageTip.applyConstraint()
        tipLabel.applyConstraint()
        blurHideTip.applyConstraint()
        minusOneLabel.applyConstraint()
    }
}
