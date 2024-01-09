//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler

class CountLifeView: ViewBuilder {
        
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var lifeImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.heartFill)
            .setTintColor(hexColor: K.ExtraColor.heartFill)
            .setSize(22)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(lifeLabel.get, .leading, -6)
            }
        return comp
    }()
    
    lazy var lifeShadowImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.heartFill)
            .setTintColor(hexColor: K.ExtraColor.heartShadow)
            .setSize(25)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(lifeImage.get, 3)
                    .setLeading.equalTo(lifeImage.get, .leading, 2)
            }
        return comp
    }()
    
    lazy var lifeLabel: LabelBuilder = {
        let comp = LabelBuilder("5")
            .setWeight(.bold)
            .setSize(18)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalToSafeArea
            }
        return comp
    }()
    
    lazy var minusHeartImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setAlpha(0)
            .setImage(systemName: K.Images.heartSlashFill)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setTintColor(hexColor: K.ExtraColor.heartFill)
            .setSize(22)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalTo(lifeImage.get)
            }
        return comp
    }()
        
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        lifeShadowImage.add(insideTo: self.get)
        lifeImage.add(insideTo: self.get)
        lifeLabel.add(insideTo: self.get)
        minusHeartImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        lifeImage.applyConstraint()
        lifeShadowImage.applyConstraint()
        lifeLabel.applyConstraint()
        minusHeartImage.applyConstraint()
    }
}
