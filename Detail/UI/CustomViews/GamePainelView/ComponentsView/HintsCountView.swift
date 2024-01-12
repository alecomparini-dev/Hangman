//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler

class HintsCountView: ViewBuilder {
    
    private var tapHints: TapGestureBuilder?
    
    override init() {
        super.init()
        configure()
    }
       
    
//  MARK: - LAZY AREA
    
    lazy var hintsImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hint)
            .setTintColor(hexColor: K.ExtraColor.lightHints)
            .setSize(17)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(hintsLabel.get, .leading, -6)
            }
        
        return comp
    }()
    
    lazy var hintsShadowImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hint)
            .setTintColor(hexColor: K.ExtraColor.heartShadow)
            .setSize(20)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(hintsImage.get, 3)
                    .setLeading.equalTo(hintsImage.get, .leading, 2)
            }
        return comp
    }()
    
    lazy var hintsLabel: LabelBuilder = {
        let comp = LabelBuilder("10")
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
        hintsShadowImage.add(insideTo: self.get)
        hintsImage.add(insideTo: self.get)
        hintsLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        hintsImage.applyConstraint()
        hintsShadowImage.applyConstraint()
        hintsLabel.applyConstraint()
    }
    
    
}
