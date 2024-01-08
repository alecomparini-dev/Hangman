//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Handler
import Presenter

public protocol HomeViewControllerCoordinator: AnyObject {
    func gotoHomeNextWord(_ dataTransfer: DataTransferDTO)
    func gotoTips(_ word: WordPresenterDTO?)
}


public class HomeViewController: UIViewController {
    public weak var coordinator: HomeViewControllerCoordinator?

    private var lettersInWord: [HangmanLetterInWordView?] = []
    
    private var dataTransfer: DataTransferDTO?
    
    private var homePresenter: HomePresenter
    
    public init(homePresenter: HomePresenter) {
        self.homePresenter = homePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: HomeView = {
        let comp = HomeView(homePresenter.getLettersKeyboard())
        return comp
    }()
    
    
//  MARK: - LIFE CICLE
    
    public override func loadView() {
        view = screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let dataTransfer {
            homePresenter.dataTransfer = dataTransfer
            homePresenter.getNextWord()
        }
    }
    
    
//  MARK: - SET DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let dataTransfer = data as? DataTransferDTO {
            self.dataTransfer = dataTransfer
            return
        }
        homePresenter.startGame()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configDelegate()        
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.gamePainelView.delegate = self
        screen.gallowsKeyboardView.delegate = self
        screen.dropdownLifeView.delegate = self
        screen.dropdownRevealLetterView.delegate = self
        homePresenter.delegateOutput = self
    }
    
    private func configNextWord(_ word: WordPresenterDTO?) {
        configGallowsWord(word)
    }
    
    private func configGallowsWord(_ word: WordPresenterDTO?) {
        screen.categoryLabel.setText(word?.category)
        screen.initialQuestionLabel.setText(word?.initialQuestion)
        configHangmanLettersInWord(word)
        configPositionLettersOfWord(word)
        setQuantityCorrectLetter(word?.word?.count)
    }
    
    private func setQuantityCorrectLetter(_ qtd: Int?) {
        screen.quantityLettersView.countCorrectLetterLabel.setText("0/\(qtd ?? 0)")
    }
        
    private func configPositionLettersOfWord(_ word: WordPresenterDTO?) {
        guard let word else { return }
        
        let indexBreakLine = identifierBreakLine(word)
        
        lettersInWord.enumerated().forEach({ index, letter in
            if index <= indexBreakLine {
                guard let letter else { return insertSpaceInStack(screen.hangmanWordView.horizontalStack1) }
                addLetterStackHorizontal1(letter)
                return
            }
            guard let letter else { return insertSpaceInStack(screen.hangmanWordView.horizontalStack2) }
            addLetterStackHorizontal2(letter)
        })
    }
    
    private func identifierBreakLine(_ word: WordPresenterDTO?) -> Int {
        var indexBreakLine = K.quantityLetterByLine
        
        guard let word, let syllables = word.syllables else { return indexBreakLine }
        
        if word.syllables?.joined().count ?? 0 <= K.quantityLetterByLine { return indexBreakLine }
    
        var acumulator = ""
        for (index, syllable) in syllables.enumerated() {
            acumulator += syllable
            if acumulator.count > K.quantityLetterByLine {
                indexBreakLine = (syllables[0...index - 1].joined().count) - 1
                break
            }
        }
        return indexBreakLine
    }
    
    private func addLetterStackHorizontal1(_ letter: HangmanLetterInWordView) {
        insertLetterInStack(letter, screen.hangmanWordView.horizontalStack1)
    }
    
    private func addLetterStackHorizontal2(_ letter: HangmanLetterInWordView) {
        if screen.hangmanWordView.horizontalStack2.get.isHidden {
            screen.hangmanWordView.horizontalStack2.setHidden(false)
        }
        insertLetterInStack(letter, screen.hangmanWordView.horizontalStack2)
    }
    
    private func insertSpaceInStack(_ horizontalStack: StackViewBuilder) {
        let space = space()
        space.add(insideTo: horizontalStack.get)
        space.applyConstraint()
    }
    
    private func space() -> ViewBuilder {
        let space = ViewBuilder()
            .setConstraints { build in
                build.setSize.equalToConstant(2)
            }
        return space
    }
    
    private func insertLetterInStack(_ letter: HangmanLetterInWordView, _ horizontalStack: StackViewBuilder) {
        letter.add(insideTo: horizontalStack.get)
        letter.applyConstraint()
    }
    
    private func configHangmanLettersInWord(_ word: WordPresenterDTO?) {
        guard let syllables = word?.syllables else {return}
        syllables.joined().uppercased().forEach { letter in
            if letter.isWhitespace {
                lettersInWord.append(nil)
                return
            }
            lettersInWord.append(createHangmanLetterInWordView(letter.description))
        }
    }
    
    private func createHangmanLetterInWordView(_ text: String) -> HangmanLetterInWordView {
        let letter = HangmanLetterInWordView(text)
            .setConstraints { build in
                build
                    .setWidth.equalToConstant(22)
                    .setHeight.equalToConstant(28)
            }
        configHifen(text, letter)
        return letter
    }
    
    private func configHifen(_ text: String, _ letter: HangmanLetterInWordView) {
        if text == K.String.hifen {
            letter.label.setHidden(false)
            letter.underlineLetter.setHidden(true)
        }
    }
    
    private func updateKeyboardLetterSuccess(_ button: UIButton) {
        let color = Theme.shared.currentTheme.primary
        setButtonPressed(button: button, color )
        setBorderButton(button, color)
        button.setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest)
    }
    
    private func updateKeyboardLetterError(_ button: UIButton) {
        let color = Theme.shared.currentTheme.error
        setButtonPressed(button: button, color )
        setBorderButton(button, color)
        button.setBackgroundColor(Theme.shared.currentTheme.surfaceContainerLow)
    }

    private func setBorderButton(_ button: UIButton, _ color: UIColor) {
        BorderBuilder(button)
            .setColor(color.withAlphaComponent(0.5))
            .setWidth(1)
    }

    private func setButtonPressed(button: UIButton, _ color: UIColor) {
        let buttonInteration = ButtonInteractionBuilder(component: button).setColor(color)
        buttonInteration.pressed
    }
    
    private func revealLetters(_ indexes: [Int], color: UIColor, isCorrectLetters: Bool = true) {
        var duration = K.Animation.Duration.standard

        indexes.forEach { index in
            guard let letter = lettersInWord[index] else { return }
            
            letter.setHidden(false)
            
            if isCorrectLetters { return configLetterForAnimation(letter, color) }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(duration)) { [weak self] in
                guard let self else {return}
                configLetterForAnimation(letter, color)
            }
            
            duration += K.Animation.Duration.increment
        }
    }
    
    private func configLetterForAnimation(_ letter: HangmanLetterInWordView, _ color: UIColor = Theme.shared.currentTheme.primary) {
        letter.label.setHidden(false)
        letter.label.setAlpha(0)
        letter.gradient?.setReferenceColor(color, percentageGradient: -20)
            .apply()
        letter.underlineLetter.setAlpha(0)
        revealLetterInWordAnimation(letter)
    }
    
    private func revealLetterInWordAnimation(_ letter: HangmanLetterInWordView) {
        AnimationHandler.fadeIn(components: [letter.label.get, letter.underlineLetter.get])
    }
    
    private func revealDollFailure(_ imageBase64: String)  {
        if let imgData = Data(base64Encoded: imageBase64) {
            var currentImage = screen.gallowsView.bodyImage.get
            AnimationHandler.transitionImage(currentImage, UIImage())
            
            currentImage = screen.gallowsView.headImage.get
            AnimationHandler.transitionImage(currentImage, UIImage(data: imgData))
        }
    }
    
    private func changeGallowsColorEndGameFailure() {
        let color = Theme.shared.currentTheme.error
        screen.gallowsView.topGallowsNeumorphism?.setReferenceColor(color).apply()
        screen.gallowsView.rodGallowsNeumorphism?.setReferenceColor(color).apply()
        screen.gallowsView.supportGallows.setBackgroundColor(color)
        screen.gallowsView.ropeGallows.setBackgroundColor(color)
        screen.gallowsView.ropeCircleGallows.setBackgroundColor(color)
    }

    private func animateDollFailureToGround() {
        AnimationHandler.moveVertical(component: screen.gallowsView.headImage.get, position: 58, delay: 0.5 )
        AnimationHandler.rotation(component: screen.gallowsView.headImage.get, rotationAngle: 75, delay: 0.6)
    }
    
    private func hideSkeleton() {
        screen.categoryLabel.skeleton?.hideSkeleton()
        screen.initialQuestionLabel.skeleton?.hideSkeleton()
        screen.hangmanWordView.skeleton?.hideSkeleton()
        screen.quantityLettersView.skeleton?.hideSkeleton()
    }
    
    private func setHideDropdownAnimation(dropdown: UIView, _ flag: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            dropdown.alpha = flag ? 0 : 1
        })
    }
    
    private func toggleDropdown(dropdown: UIView) {
        setHideDropdownAnimation(dropdown: dropdown, !(dropdown.alpha == 0.0))
    }
    
    
}


//  MARK: - EXTENSION - HangmanKeyboardViewDelegate

extension HomeViewController: HangmanViewDelegate {
    
    func nextWordButtonTapped() {
        if let dataTransferDTO = homePresenter.dataTransfer {
            coordinator?.gotoHomeNextWord(dataTransferDTO)
        }
    }
    
}


//  MARK: - EXTENSION - GamePainelViewDelegate

extension HomeViewController: GamePainelViewDelegate {
    
    func countLifeViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        toggleDropdown(dropdown: screen.dropdownLifeView.get)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            if let dropdown = self?.screen.dropdownRevealLetterView.get {
                self?.setHideDropdownAnimation(dropdown: dropdown, true)
            }
        })
    }
    
    func countTipsViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        setHideDropdownAnimation(dropdown: screen.dropdownLifeView.get, true)
        setHideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get, true)
        coordinator?.gotoTips(homePresenter.getCurrentWord())
    }
    
    func revealLetterViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        toggleDropdown(dropdown: screen.dropdownRevealLetterView.get)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            if let dropdown = self?.screen.dropdownLifeView.get {
                self?.setHideDropdownAnimation(dropdown: dropdown, true)
            }
        })
    }
    
}



//  MARK: - EXTENSION - DropdownLifeViewDelegate
extension HomeViewController: DropdownLifeViewDelegate {
    
    func closeDropDown() {
        setHideDropdownAnimation(dropdown: screen.dropdownLifeView.get , true)
    }
    
}


//  MARK: - EXTENSION - DropdownRevealLetterViewDelegate
extension HomeViewController: DropdownRevealLetterViewDelegate {
    
    func closeDropDownRevealLetter() {
        setHideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get , true)
    }
    
}



//  MARK: - EXTENSION - HangmanKeyboardViewDelegate

extension HomeViewController: HangmanKeyboardViewDelegate {
    
    func letterButtonTapped(_ button: UIButton) {
        homePresenter.verifyMatchInWord(button.titleLabel?.text)
    }
    
    func moreTipTapped() {
        coordinator?.gotoTips(homePresenter.getCurrentWord())
    }
    
    
}


//  MARK: - EXTENSION - ProfileSummaryPresenterOutput

extension HomeViewController: HomePresenterOutput {
    
    public func revealHeadDoll(_ imageBase64: String) {
        screen.gallowsView.ropeCircleGallows.setHidden(true)
        if let imgData = Data(base64Encoded: imageBase64) {
            let currentImage = screen.gallowsView.headImage.get
            AnimationHandler.transitionImage(currentImage, UIImage(data: imgData))
        }
    }
    
    public func revealBodyDoll(_ imageBase64: String) {
        if let imgData = Data(base64Encoded: imageBase64) {
            let currentImage = screen.gallowsView.bodyImage.get
            AnimationHandler.transitionImage(currentImage, UIImage(data: imgData))
        }
    }
    
    public func revealDollEndGameSuccess(_ imageBase64: String) {
        if let imgData = Data(base64Encoded: imageBase64) {
            screen.gallowsView.bodyImage.setHidden(true)
            screen.gallowsView.headImage.setImage(image: UIImage(data: imgData))
            AnimationHandler.moveVertical(component: screen.gallowsView.headImage.get, position: 35, delay: 0.5)
        }
    }
    
    public func revealDollEndGameFailure(_ imageBase64: String) {
        revealDollFailure(imageBase64)
        changeGallowsColorEndGameFailure()
        animateDollFailureToGround()
    }
    
    public func revealCorrectLetters(_ indexes: [Int]) {
        revealLetters(indexes, color: Theme.shared.currentTheme.primary.withAlphaComponent(0.4))
    }
    
    public func revealErrorLetters(_ indexes: [Int]) {
        revealLetters(indexes, color: Theme.shared.currentTheme.error.withAlphaComponent(0.8), isCorrectLetters: false)
    }

    public func revealChosenKeyboardLetter(isCorrect: Bool, _ keyboardLetter: String) {
        guard let tag = K.Keyboard.letter[keyboardLetter.uppercased()] else { return }
        guard let button = screen.gallowsKeyboardView.get.viewWithTag(tag) as? UIButton else { return }
        button.removeNeumorphism()
        if isCorrect {
            updateKeyboardLetterSuccess(button)
            return
        }
        updateKeyboardLetterError(button)
    }

    public func updateCountCorrectLetters(_ count: String) {
        screen.quantityLettersView.countCorrectLetterLabel.setText(count)
    }
    
    public func successFetchNextWord(word: WordPresenterDTO?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.hideSkeleton()
        })
        configNextWord(word)
    }
    
    public func nextWordIsOver(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    public func errorFetchNextWords(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
