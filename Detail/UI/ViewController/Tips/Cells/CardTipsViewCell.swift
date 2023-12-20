//  Created by Alessandro Comparini on 18/12/23.
//

import UIKit
import CustomComponentsSDK
import Presenter

class CardTipsViewCell: UIView {
    
    private let word: WordPresenterDTO?
    
    init(_ word: WordPresenterDTO?) {
        self.word = word
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//  MARK: - LAZY AREA
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.secondary.adjustBrightness(80))
            .setBorder({ build in
                build
                    .setCornerRadius(16)
//                    .setWidth(0.5)
//                    .setColor(hexColor: "#baa0f4")
            })
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea(4)
            }
        return comp
    }()
        
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
    }
    
}
