//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit
import CustomComponentsSDK
import Handler

class TipsCountView: ViewBuilder {
    
    private var tapTips: TapGestureBuilder?
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var tipsImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hint)
            .setTintColor(hexColor: K.ExtraColor.lightHints)
            .setSize(17)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(tipsLabel.get, .leading, -6)
            }
        
        return comp
    }()
    
    lazy var tipsShadowImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hint)
            .setTintColor(hexColor: K.ExtraColor.heartShadow)
            .setSize(20)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(tipsImage.get, 3)
                    .setLeading.equalTo(tipsImage.get, .leading, 2)
            }
        return comp
    }()
    
    lazy var tipsLabel: LabelBuilder = {
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
        tipsShadowImage.add(insideTo: self.get)
        tipsImage.add(insideTo: self.get)
        tipsLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        tipsImage.applyConstraint()
        tipsShadowImage.applyConstraint()
        tipsLabel.applyConstraint()
    }
    
    
}
