//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler

class CountRevealLetterView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //  MARK: - LAZY AREA
    
    lazy var revealImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.eyeFill)
            .setTintColor(Theme.shared.currentTheme.primary)
            .setSize(18)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(revealLabel.get, .leading, -6)
            }
        return comp
    }()
    
    lazy var revealShadowImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.eyeFill)
            .setTintColor(hexColor: K.ExtraColor.heartShadow)
            .setSize(20)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(revealImage.get, 2)
                    .setLeading.equalTo(revealImage.get, .leading, 2)
            }
        return comp
    }()
    
    lazy var revealLabel: LabelBuilder = {
        let comp = LabelBuilder("05")
            .setTextAlignment(.left)
            .setSize(16)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setSkeleton({ build in
                build
                    .setCornerRadius(4)
                    .setColorSkeleton(Theme.shared.currentTheme.surfaceContainerHigh)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalToSafeArea
                    .setWidth.equalToConstant(25)
            }
        return comp
    }()
    
    
    //  MARK: - Title
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        revealShadowImage.add(insideTo: self.get)
        revealImage.add(insideTo: self.get)
        revealLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        revealImage.applyConstraint()
        revealShadowImage.applyConstraint()
        revealLabel.applyConstraint()
    }
    
}

