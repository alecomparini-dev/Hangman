//  Created by Alessandro Comparini on 14/12/23.
//

import UIKit

import CustomComponentsSDK
import Handler

protocol GameHelpPainelViewDelegate: AnyObject {
    func livesCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func hintsCountViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
    func revelationsCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder)
}


class GameHelpPainelView: ViewBuilder {
    weak var delegate: GameHelpPainelViewDelegate?
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
//  MARK: - LAZY AREA
    
    lazy var revelationsCountView: RevealLetterCountView = {
        let comp = RevealLetterCountView()
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSafeArea
                    .setTrailing.equalTo(hintsCountView.hintsImage.get, .leading, -4)
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

    lazy var hintsCountView: HintsCountView = {
        let comp = HintsCountView()
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
                        delegate?.hintsCountViewTapped(tapGesture, hintsCountView)
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
        hintsCountView.add(insideTo: self.get)
        revelationsCountView.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        livesCountView.applyConstraint()
        hintsCountView.applyConstraint()
        revelationsCountView.applyConstraint()
    }
    
}
