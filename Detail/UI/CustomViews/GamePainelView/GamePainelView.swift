//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler


protocol GamePainelViewDelegate: AnyObject {
    func countLifeDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func countTipsViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func countRevealLetterDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
}


class GamePainelView: ViewBuilder {
    weak var delegate: GamePainelViewDelegate?
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var countRevealLetterView: CountRevealLetterView = {
        let comp = CountRevealLetterView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countTipsView.tipsImage.get, .leading, -4)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(45)
            }
        return comp
    }()

    lazy var countTipsView: CountTipsView = {
        let comp = CountTipsView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(countLifeView.lifeImage.get, .leading, -8)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(45)
            }
        return comp
    }()
        
    lazy var countLifeView: CountLifeView = {
        let comp = CountLifeView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalToSafeArea(-36)
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
        countRevealLetterView.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        countLifeView.applyConstraint()
        countTipsView.applyConstraint()
        countRevealLetterView.applyConstraint()
    }
    
    private func configTapGesture() {
        TapGestureBuilder(countLifeView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.countLifeDropdownViewTapped(tapGesture, countLifeView)
            }
        
        TapGestureBuilder(countTipsView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.countTipsViewTapped(tapGesture, countTipsView)
            }
        
        TapGestureBuilder(countRevealLetterView.get)
            .setTap { [weak self] tapGesture in
                guard let self else { return }
                delegate?.countRevealLetterDropdownViewTapped(tapGesture, countRevealLetterView)
            }
    }
    
    
}
