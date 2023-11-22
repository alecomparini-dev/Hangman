//  Created by Alessandro Comparini on 14/11/23.
//


import UIKit
import CustomComponentsSDK

class HangmanLetterInWordView: ViewBuilder {
    
    private var gradient: GradientBuilder?
    private let letter: String
    
    init(_ letter: String) {
        self.letter = letter
        super.init()
        configure()
    }
    
    private func configure() {
        addElements()
        configConstraints()
    }
    
    
//  MARK: - LAZY Area
    
    lazy var label: LabelBuilder = {
        let label = LabelBuilder(letter)
            .setHidden(true)
            .setSize(22)
            .setWeight(.medium)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return label
    }()
    
    lazy var underlineLetter: ViewBuilder = {
        let view = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest)
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black)
                    .setOpacity(1)
                    .setRadius(3)
                    .applyLayer(size: CGSize(width: 22, height: 2))
            })
            .setGradient({ build in
                build
                    .setGradientColors([Theme.shared.currentTheme.surfaceContainerHigh, Theme.shared.currentTheme.surfaceContainerHighest])
                    .setAxialGradient(.leftToRight)
                    .apply(size: CGSize(width: 22, height: 2))
            })
            .setConstraints { build in
                build
                    .setBottom.setLeading.setTrailing.equalToSuperView
                    .setHeight.equalToConstant(2)
            }
       return view
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        label.add(insideTo: self.get)
        underlineLetter.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        label.applyConstraint()
        underlineLetter.applyConstraint()
    }
    
    
}
