//  Created by Alessandro Comparini on 05/01/24.
//

import UIKit

import CustomComponentsSDK
import Handler

protocol DropdownLifeViewDelegate: AnyObject {
    func closeDropDown()
}

class DropdownLifeView: ViewBuilder {
    weak var delegate: DropdownLifeViewDelegate?
    
    override init() {
        super.init()
        configure()
    }

    
//  MARK: - LAZY AREA
    
    lazy var overlay: BlurBuilder = {
        let overlay = BlurBuilder(style: .dark)
            .setConstraints { build in
                build
                    .setPin.equalTo(self.get)
            }
            .setActions { build in
                build
                    .setTap { [weak self] component, tapGesture in
                        self?.delegate?.closeDropDown()
                    }
            }
        return overlay
    }()
    
    lazy var arrowUpImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.triangleFill)
            .setTintColor(Theme.shared.currentTheme.surfaceContainerHigh)
            .setContentMode(.center)
            .setSize(32)
            .setConstraints { build in
                build
                    .setTop.equalTo(painelView.get, .top, -24)
                    .setTrailing.equalTo(painelView.get, .trailing, -30)
            }
        return comp
    }()
    
    lazy var painelView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 5)
                    .setBlur(to: .dark, percent: 10)
                    .setDistance(to: .light, percent: 5)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(self.get, .top, 16)
                    .setLeading.equalTo(self.get, .leading, 40)
                    .setTrailing.equalTo(self.get, .trailing, -16)
                    .setHeight.equalToConstant(350)
            }
        return comp
    }()
    
    lazy var titleLabel: LabelBuilder = {
        let comp = LabelBuilder(K.String.life)
            .setSize(26)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setWeight(.thin)
            .setShadow { build in
                build
                    .setColor(Theme.shared.currentTheme.onPrimary)
                    .setRadius(5)
                    .setOffset(width: 4, height: 4)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(painelView.get, .top, 16)
                    .setHorizontalAlignmentX.equalTo(painelView.get)
            }
        return comp
    }()
    
    lazy var stackLifeHeart: StackViewBuilder = {
        let comp = StackViewBuilder()
            .setAxis(.horizontal)
            .setSpacing(8)
            .setAlignment(.center)
            .setDistribution(.equalSpacing)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleLabel.get, .bottom, 12)
                    .setHorizontalAlignmentX.equalToSuperView
            }
        return comp
    }()
    
    lazy var restartLifeLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurface)
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setTextAttributed { build in
                build
                    .setText(text: "As ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setText(text: "vidas ")
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.error.adjustBrightness(30))
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 20, weight: .light))
                    .setText(text: "reiniciam às ")
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onSurface)
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setText(text: "00:00 ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15, weight: .black))
                    .setText(text: "horas")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(stackLifeHeart.get, .bottom, 12)
                    .setLeading.setTrailing.equalTo(painelView.get, 4)
            }
        return comp
    }()
    
    
    
    lazy var adLifePainel: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(4)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHighest)
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 8)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(restartLifeLabel.get, .bottom, 24)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setHeight.equalToConstant(68)
            }
        return comp
    }()
    
    
    lazy var buyLifePainel: BuyLifePainelView = {
        let comp = BuyLifePainelView()
            .setConstraints { build in
                build
                    .setTop.equalTo(adLifePainel.get, .bottom, 20)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setHeight.equalToConstant(68)
            }
        return comp
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        overlay.add(insideTo: self.get)
        arrowUpImage.add(insideTo: self.get)
        painelView.add(insideTo: self.get)
        titleLabel.add(insideTo: painelView.get)
        stackLifeHeart.add(insideTo: painelView.get)
        addHeartImage()
        restartLifeLabel.add(insideTo: painelView.get)
        adLifePainel.add(insideTo: painelView.get)
        buyLifePainel.add(insideTo: painelView.get)
    }
    
    private func configConstraints() {
        overlay.applyConstraint()
        arrowUpImage.applyConstraint()
        painelView.applyConstraint()
        titleLabel.applyConstraint()
        stackLifeHeart.applyConstraint()
        restartLifeLabel.applyConstraint()
        adLifePainel.applyConstraint()
        buyLifePainel.applyConstraint()
    }
    
    private func addHeartImage() {
        let tagsHearts = (1...5)
        tagsHearts.forEach { tag in
            let heart = makeHeartImage()
            heart.setTag(tag)
            heart.add(insideTo: stackLifeHeart.get)
        }
    }
    
    private func makeHeartImage() -> ImageViewBuilder {
        return ImageViewBuilder(systemName: K.Images.heartFill)
            .setSize(32)
            .setContentMode(.center)
            .setWeight(.bold)
            .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
    }
    
    
}
