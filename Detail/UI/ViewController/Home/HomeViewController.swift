//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Handler
import Presenter

public protocol HomeViewControllerCoordinator: AnyObject {
    func gotoHomeNextWord(_ dataTransfer: DataTransferHomeVC)
    func gotoHints(_ dataTransfer: DataTransferHintsVC?)
}


public class HomeViewController: UIViewController {
    public weak var coordinator: HomeViewControllerCoordinator?

    let animations: HomeAnimation = HomeAnimation()
    private let tagImage = 10
    
    var buttonReveal: UIView?
    private var lettersInWord: [HangmanLetterInWordView?] = []
    private var dataTransfer: DataTransferHomeVC?
    
    
//  MARK: - INITIALIZERS
    
    var homePresenter: HomePresenter { _homePresenter }
    private var _homePresenter: HomePresenter
    
    public init(homePresenter: HomePresenter) {
        self._homePresenter = homePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var screen: HomeView { _screen }
    private lazy var _screen: HomeView = {
        let comp = HomeView(_homePresenter.getLettersKeyboard())
        return comp
    }()
    
    
//  MARK: - LIFE CICLE
    
    public override func loadView() {
        view = screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let dataTransfer {
            _homePresenter.dataTransfer = dataTransfer
            homePresenter.getNextWord()
            return
        }
        showSkeletonGameHelp()
    }
    
    
//  MARK: - SET DATA TRANSFER
    public func setDataTransfer(_ data: Any?) {
        if let dataTransfer = data as? DataTransferHomeVC {
            self.dataTransfer = dataTransfer
            return
        }
        
        _homePresenter.startGame()
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
        _homePresenter.delegateOutput = self
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
    
    private func updateMarkGameHelp() {
        updateMarkUsedButtonRevealLetter()
        updateMarkUsedLife()
    }
    
    private func updateMarkUsedButtonRevealLetter() {
        let countRevelations = (homePresenter.gameHelpPresenter?.revelationsCount ?? 0)
        let maxRevelations = homePresenter.maxHelp(.revelations)
        
        for index in stride(from: countRevelations+1, through: maxRevelations, by: 1) {
            let comp = screen.dropdownRevealLetterView.stackEyes.get.viewWithTag(Int(index))
            markUsedButtonReveal(comp)
        }
    }
    
    private func updateMarkUsedLife() {
        let livesCount = (homePresenter.gameHelpPresenter?.livesCount ?? 0)
        let maxLives = homePresenter.maxHelp(.lives)
        for index in stride(from: livesCount+1, through: maxLives, by: 1) {
            if let comp = screen.dropdownLifeView.stackLifeHeart.get.viewWithTag(Int(index)) as? UIImageView {
                comp.tintColor = Theme.shared.currentTheme.onSurfaceVariant
            }
        }
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
        let space = ViewBuilder()
            .setConstraints { build in
                build.setSize.equalToConstant(2)
            }
        space.add(insideTo: horizontalStack.get)
        space.applyConstraint()
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
    
    private func hideSkeletonGameHelp() {
        screen.gamePainelView.livesCountView.lifeLabel.skeleton?.hideSkeleton()
        screen.gamePainelView.hintsCountView.hintsLabel.skeleton?.hideSkeleton()
        screen.gamePainelView.revelationsCountView.revealLabel.skeleton?.hideSkeleton()
    }
    
    private func showSkeletonGameHelp() {
        screen.gamePainelView.livesCountView.lifeLabel.skeleton?.showSkeleton()
        screen.gamePainelView.hintsCountView.hintsLabel.skeleton?.showSkeleton()
        screen.gamePainelView.revelationsCountView.revealLabel.skeleton?.showSkeleton()
    }
    
    private func markUsedButtonReveal(_ component: UIView?) {
        guard let component else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            guard let self else { return }
            component.removeNeumorphism()
            component.isUserInteractionEnabled = false
            if let img = component.viewWithTag(component.tag + tagImage) as? UIImageView {
                img.image = UIImage(systemName: K.Images.eyeFill)
                img.image = img.image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 22))
                img.tintColor = Theme.shared.currentTheme.onSurfaceVariant
            }
        })
    }
    
    func makeDataTransferTipVC() -> DataTransferHintsVC {
        return DataTransferHintsVC(
            wordPresenterDTO: _homePresenter.getCurrentWord(),
            gameHelpPresenterDTO: _homePresenter.dataTransfer?.gameHelpPresenterDTO,
            updateTipCompletion: updateHintsCount
        )
    }
    
}



//  MARK: - EXTENSION - HomePresenterOutput

extension HomeViewController: HomePresenterOutput {
    public func updateGameHelp(_ gameHelp: GameHelpPresenterDTO) {
        screen.gamePainelView.livesCountView.lifeLabel.get.text = gameHelp.livesCount.description
        screen.gamePainelView.hintsCountView.hintsLabel.get.text = gameHelp.hintsCount.description
        screen.gamePainelView.revelationsCountView.revealLabel.get.text = gameHelp.revelationsCount.description
        updateMarkGameHelp()
        hideSkeletonGameHelp()
    }
    
    public func updateLivesCount(_ count: String) {
        updateMarkUsedLife()
        animations.minusHeart(count,
                              minusHeartImage: screen.gamePainelView.livesCountView.minusHeartImage.get,
                              lifeLabel: screen.gamePainelView.livesCountView.lifeLabel.get)
        
    }
    
    public func updateHintsCount(_ count: String) {
        screen.gamePainelView.hintsCountView.hintsLabel.get.text = count
    }
    
    public func updateRevelationsCount(_ count: String) {
        animations.hideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get)

        markUsedButtonReveal(buttonReveal)

        animations.pulseAnimationRevealingImage(screen.revealingImage.get)

        animations.minusRevelation(count,
                                   minusOneRevealLabel: screen.minusOneRevealLabel.get,
                                   revealLabel: screen.gamePainelView.revelationsCountView.revealLabel.get)
    }
    
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                guard let self else {return}
                animations.stopPulseAnimationRevealingImage(screen.revealingImage.get)
            })
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
        hideSkeleton()
    }
    
    public func errorFetchNextWords(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}
