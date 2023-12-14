//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit

import CustomComponentsSDK

class TipsView: UIView {
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
//            .setBackgroundColor(.red)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        configGrandient()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
    }

    private func configConstraints() {
        backgroundView.applyConstraint()
    }
    
    public func configGrandient() {
        backgroundView.get.makeGradient { make in
            make
                .setReferenceColor(Theme.shared.currentTheme.secondary.adjustBrightness(30), percentageGradient: 100)
                .setAxialGradient(.rightBottomToLeftTop)
                .apply(size: CurrentWindow.get?.frame.size ?? CGSize())
        }
    }
    
}
