//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler


protocol GameHelpPainelViewDelegate: AnyObject {
    func livesCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func tipsCountViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func revelationsCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
}


class GameHelpPainelView: ViewBuilder {
    weak var delegate: GameHelpPainelViewDelegate?
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var revelationsCountView: RevealLetterCountView = {
        let comp = RevealLetterCountView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(tipsCountView.tipsImage.get, .leading, -4)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(60)
            }
            .setActions { build in
                build
                    .setTap { [weak self] _ , tapGesture  in
                        guard let self, let tapGesture else { return }
                        delegate?.revelationsCountDropdownViewTapped(tapGesture, revelationsCountView)
                    }
            }
        return comp
    }()

    lazy var tipsCountView: TipsCountView = {
        let comp = TipsCountView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(livesCountView.lifeImage.get, .leading, -8)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(55)
            }
            .setActions { build in
                build
                    .setTap { [weak self] _ , tapGesture  in
                        guard let self, let tapGesture else { return }
                        delegate?.tipsCountViewTapped(tapGesture, tipsCountView)
                    }
            }
        return comp
    }()
        
    lazy var livesCountView: LivesCountView = {
        let comp = LivesCountView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalToSafeArea(-36)
                    .setTop.setBottom.equalToSafeArea
                    .setWidth.equalToConstant(55)
            }
            .setActions { build in
                build
                    .setTap { [weak self] _ , tapGesture  in
                        guard let self, let tapGesture else { return }
                        delegate?.livesCountDropdownViewTapped(tapGesture, livesCountView)
                    }
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        livesCountView.add(insideTo: self.get)
        tipsCountView.add(insideTo: self.get)
        revelationsCountView.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        livesCountView.applyConstraint()
        tipsCountView.applyConstraint()
        revelationsCountView.applyConstraint()
    }
    
}
