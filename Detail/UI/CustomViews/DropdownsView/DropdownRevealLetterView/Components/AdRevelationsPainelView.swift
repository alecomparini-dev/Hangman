//  Created by Alessandro Comparini on 07/01/24.
//

import UIKit
import CustomComponentsSDK
import Handler

class AdRevelationsPainelView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    //  MARK: - LAZY AREA
        
    lazy var containerEyeBackgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setBottom.setTrailing.equalToSuperView
                    .setSize.equalToConstant(60)
            }
        comp.get.clipsToBounds = true
        return comp
    }()
    
    lazy var eyeBackgroundImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.eyeFill)
            .setTintColor(Theme.shared.currentTheme.surfaceContainerHighest.adjustBrightness(40))
            .setWeight(.thin)
            .setContentMode(.center)
            .setSize(50)
            .setConstraints { build in
                build
                    .setBottom.equalToSuperView(20)
                    .setTrailing.equalToSuperView(13)
            }
        comp.get.transform = CGAffineTransform(rotationAngle: -10.degreesToPI)
        return comp
    }()
    
    lazy var descriptionLabel: LabelBuilder = {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 2
        
        let overlay = LabelBuilder()
            .setColor(.white)
            .setNumberOfLines(2)
            .setTextAttributed({ build in
                build
                    .setText(text: "Assista o vídeo e")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 16))
                    .setText(text: "\n   ganhe ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 16))
                    .setText(text: "+1")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17, weight: .bold))
                    .setText(text: " revelação")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 22, weight: .bold))
                    .setAttributed(key: .shadow, value: shadow )
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-2)
                    .setLeading.equalToSuperView(10)
            }
        return overlay
    }()
    
    lazy var adPlayImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "play.rectangle.fill")
            .setTintColor(Theme.shared.currentTheme.onPrimaryContainer)
            .setWeight(.bold)
            .setContentMode(.center)
            .setSize(32)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalToSuperView(-24)
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE
    private func configure() {
        addElements()
        configConstraints()
        configStyle()
    }
    
    private func addElements() {
        containerEyeBackgroundView.add(insideTo: self.get)
        eyeBackgroundImage.add(insideTo: containerEyeBackgroundView.get)
        descriptionLabel.add(insideTo: self.get)
        adPlayImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        containerEyeBackgroundView.applyConstraint()
        eyeBackgroundImage.applyConstraint()
        descriptionLabel.applyConstraint()
        adPlayImage.applyConstraint()
    }
    
    private func configStyle() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self
            .setBorder({ build in
                build
                    .setCornerRadius(4)
            })
    }
    
    private func configNeumorphism() {
        self
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
    }
    
    
}
