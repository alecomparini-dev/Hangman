//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler

class ScoreView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var countLifeView: CountLifeView = {
        let comp = CountLifeView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalToSafeArea(-48)
                    .setTop.setBottom.equalToSafeArea
            }
        return comp
    }()
    
    
    lazy var countTipsView: CountTipsView = {
        let comp = CountTipsView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countLifeView.lifeImage.get, .leading, -15)
                    .setTop.setBottom.equalToSafeArea
            }
        return comp
    }()
    
    lazy var revealLetterView: CountRevealLetterView = {
        let comp = CountRevealLetterView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countTipsView.tipsImage.get, .leading, -18)
                    .setTop.setBottom.equalToSafeArea
            }
        return comp
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    
    private func addElements() {
        countLifeView.add(insideTo: self.get)
        countTipsView.add(insideTo: self.get)
        revealLetterView.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        countLifeView.applyConstraint()
        countTipsView.applyConstraint()
        revealLetterView.applyConstraint()
    }
    
    
}
