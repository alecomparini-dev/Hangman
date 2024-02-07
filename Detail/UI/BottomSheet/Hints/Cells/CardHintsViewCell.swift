//  Created by Alessandro Comparini on 18/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler
import Presenter

protocol CardHintsViewCellDelegate: AnyObject {
    func openHints(_ cardHintsViewCell: CardHintsViewCell)
}

class CardHintsViewCell: UIView {
    weak var delegate: CardHintsViewCellDelegate?
    
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
    
    lazy var hintImageView: ViewBuilder = {
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
                        delegate?.openHints(self)
                    })
            }
        return comp
    }()
    
    lazy var imageHint: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hintClose)
            .setTintColor(Theme.shared.currentTheme.onSecondary.withAlphaComponent(0.8))
            .setContentMode(.scaleAspectFit)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(hintImageView.get, 2)
                    .setHorizontalAlignmentX.equalTo(hintImageView.get, -1)
                    .setSize.equalToConstant(26)
            }
        return comp
    }()
    
    lazy var lockedImageHint: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hintLocked)
            .setTintColor(Theme.shared.currentTheme.onSecondary)
            .setContentMode(.scaleAspectFit)
            .setConstraints { build in
                build
                    .setTrailing.equalTo(imageHint.get, .trailing, 2)
                    .setBottom.equalTo(imageHint.get, .bottom)
                    .setSize.equalToConstant(16)
            }
        return comp
    }()
    
    lazy var hintLabel: LabelBuilder = {
        let comp = LabelBuilder(word)
            .setColor(.white)
            .setWeight(.bold)
            .setSize(15)
            .setNumberOfLines(3)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setLeading.equalTo(hintImageView.get, .trailing, 12)
                    .setTrailing.equalToSafeArea(-16)
            }
        return comp
    }()

    lazy var blurHideTip: BlurBuilder = {
        let comp = BlurBuilder(style: .light)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build
                    .setTop.setTrailing.setBottom.equalTo(backgroundView.get, 16)
                    .setLeading.equalTo(hintLabel.get, .leading)
            }
            .setActions { build in
                build
                    .setTap ({ [weak self] component, tapGesture in
                        guard let self else {return}
                        delegate?.openHints(self)
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
                    .setTop.setTrailing.equalTo(hintImageView.get)
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
        hintImageView.add(insideTo: self)
        imageHint.add(insideTo: hintImageView.get)
        lockedImageHint.add(insideTo: hintImageView.get)
        hintLabel.add(insideTo: self)
        blurHideTip.add(insideTo: self)
        minusOneLabel.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        hintImageView.applyConstraint()
        imageHint.applyConstraint()
        lockedImageHint.applyConstraint()
        hintLabel.applyConstraint()
        blurHideTip.applyConstraint()
        minusOneLabel.applyConstraint()
    }
}
