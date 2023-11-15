//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit
import CustomComponentsSDK

protocol HangmanKeyboardLetterViewDelegate: AnyObject {
    func letterKeyboardTapped(_ letter: HangmanKeyboardLetterView)
}

class HangmanKeyboardLetterView: ViewBuilder {
    weak var delegate: HangmanKeyboardLetterViewDelegate?
    
    private let color: UIColor
    private(set) var text: String
    
    init(_ text: String, _ color: UIColor) {
        self.text = text
        self.color = color
        super.init()
        configure()
    }
    

//  MARK: - LAZY AREA
    
    lazy var gallowsLetter: DefaultViewButton = {
        let button = DefaultViewButton(self.color, self.text)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        button.button.get.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
        return button
    }()


//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        gallowsLetter.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        gallowsLetter.applyConstraint()
    }
    

//  MARK: - @OBJC Area
    @objc private func letterTapped(_ sender: UIButton) {
        delegate?.letterKeyboardTapped(self)
    }
    
}

