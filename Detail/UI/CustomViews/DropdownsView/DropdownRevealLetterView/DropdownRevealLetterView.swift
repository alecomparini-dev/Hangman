//  Created by Alessandro Comparini on 05/01/24.
//

import UIKit

import CustomComponentsSDK
import Handler

protocol DropdownRevealLetterViewDelegate: AnyObject {
    func closeDropDownRevealLetter()
}


class DropdownRevealLetterView: ViewBuilder {
    weak var delegate: DropdownRevealLetterViewDelegate?
    
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
                        self?.delegate?.closeDropDownRevealLetter()
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
                    .setTrailing.equalTo(painelView.get, .trailing, -156)
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
                    .setHeight.equalToConstant(250)
            }
        return comp
    }()
    
    lazy var titleLabel: LabelBuilder = {
        let comp = LabelBuilder(K.String.revealLetter)
            .setSize(24)
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
    
    lazy var stackEyes: StackViewBuilder = {
        let comp = StackViewBuilder()
            .setAxis(.horizontal)
            .setSpacing(8)
            .setAlignment(.center)
            .setDistribution(.equalSpacing)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleLabel.get, .bottom, 8)
                    .setHorizontalAlignmentX.equalToSuperView
                    .setHeight.equalToConstant(60)
            }
        return comp
    }()
    
    lazy var restartRevealLetterLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurface)
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setTextAttributed { build in
                build
                    .setText(text: "As ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setText(text: "revelações ")
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.primary)
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18, weight: .thin))
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
                    .setTop.equalTo(stackEyes.get, .bottom, 4)
                    .setLeading.setTrailing.equalTo(painelView.get, 4)
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
        stackEyes.add(insideTo: painelView.get)
        addEyeImage()
        restartRevealLetterLabel.add(insideTo: painelView.get)
    }
    
    private func configConstraints() {
        overlay.applyConstraint()
        arrowUpImage.applyConstraint()
        painelView.applyConstraint()
        titleLabel.applyConstraint()
        stackEyes.applyConstraint()
        restartRevealLetterLabel.applyConstraint()
    }
    
    private func addEyeImage() {
        let tagsEyes = (1...5)
        tagsEyes.forEach { tag in
            let eye = makeEyeImage()
            eye.setTag(tag)
            eye.add(insideTo: stackEyes.get)
        }
    }
    
    private func makeEyeImage() -> ImageViewBuilder {
        return ImageViewBuilder(systemName: K.Images.eyeFill)
            .setSize(26)
            .setContentMode(.center)
            .setWeight(.bold)
            .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
    }
    
    
}
