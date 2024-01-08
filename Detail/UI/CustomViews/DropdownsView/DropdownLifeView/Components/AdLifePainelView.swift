//  Created by Alessandro Comparini on 07/01/24.
//

import UIKit
import CustomComponentsSDK
import Handler

class AdLifePainelView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    //  MARK: - LAZY AREA
    
    lazy var heartImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.heartFill)
            .setTintColor(Theme.shared.currentTheme.error.adjustBrightness(100))
            .setWeight(.thin)
            .setContentMode(.center)
            .setSize(40)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(-18)
                    .setLeading.equalToSuperView(-16)
            }
        return comp
    }()
    
    lazy var containerHeartBackgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setBottom.setTrailing.equalToSuperView
                    .setSize.equalToConstant(60)
            }
        comp.get.clipsToBounds = true
        return comp
    }()
    
    lazy var heartBackgroundImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.heartFill)
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
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17))
                    .setText(text: "\n    ganhe ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17))
                    .setText(text: " +1")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17, weight: .bold))
                    .setText(text: " vida")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 26, weight: .bold))
                    .setAttributed(key: .shadow, value: shadow )
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-2)
                    .setLeading.equalTo(heartImage.get, .trailing, 12)
            }
        return overlay
    }()
    
    lazy var adPlayImage: ImageViewBuilder = {
//        let comp = ImageViewBuilder(systemName: "play.rectangle.fill")
        let comp = ImageViewBuilder(systemName: "play.circle.fill")
            .setTintColor(Theme.shared.currentTheme.onPrimaryContainer)
            .setWeight(.bold)
            .setContentMode(.center)
            .setSize(40)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalToSuperView(-32)
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
        heartImage.add(insideTo: self.get)
        containerHeartBackgroundView.add(insideTo: self.get)
        heartBackgroundImage.add(insideTo: containerHeartBackgroundView.get)
        descriptionLabel.add(insideTo: self.get)
        adPlayImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        heartImage.applyConstraint()
        containerHeartBackgroundView.applyConstraint()
        heartBackgroundImage.applyConstraint()
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
    
//    private func sendHeartToBack() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self else {return}
//            self.get.sendSubviewToBack(heartImage.get)
//        }
//    }
    
}
