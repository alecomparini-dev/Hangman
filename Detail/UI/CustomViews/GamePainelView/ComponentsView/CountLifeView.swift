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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
    
//  MARK: - Title
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        lifeShadowImage.add(insideTo: self.get)
        lifeImage.add(insideTo: self.get)
        lifeLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        lifeImage.applyConstraint()
        lifeShadowImage.applyConstraint()
        lifeLabel.applyConstraint()
    }
}
