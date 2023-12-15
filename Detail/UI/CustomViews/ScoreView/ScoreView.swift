//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler


protocol ScoreViewDelegate: AnyObject {
    func countLifeViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func countTipsViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func revealLetterViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
}


class ScoreView: ViewBuilder {
    weak var delegate: ScoreViewDelegate?
    
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
                    .setWidth.equalToConstant(50)
            }
        return comp
    }()
    
    lazy var countTipsView: CountTipsView = {
        let comp = CountTipsView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countLifeView.lifeImage.get, .leading, -18)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(50)
            }
        return comp
    }()
    
    lazy var revealLetterView: CountRevealLetterView = {
        let comp = CountRevealLetterView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countTipsView.tipsImage.get, .leading, -21)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(50)
            }
        return comp
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        configTapGesture()
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
    
    private func configTapGesture() {
        TapGestureBuilder(countLifeView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.countLifeViewTapped(tapGesture, countLifeView)
            }
        
        TapGestureBuilder(countTipsView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.countTipsViewTapped(tapGesture, countTipsView)
            }
        
        TapGestureBuilder(revealLetterView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.revealLetterViewTapped(tapGesture, revealLetterView)
            }
    }
    
    
}
