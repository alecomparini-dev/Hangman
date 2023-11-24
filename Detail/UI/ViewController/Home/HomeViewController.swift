//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Handler
import Presenter


public class HomeViewController: UIViewController {

    private var lettersInWord: [HangmanLetterInWordView?] = []
    
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
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configDelegate()
        homePresenter.startGame()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.gallowsKeyboardView.delegate = self
        homePresenter.delegateOutput = self
    }
    
    private func configNextWord(_ word: NextWordPresenterDTO?) {
        configGallowsWord(word)
    }
    
    private func configGallowsWord(_ word: NextWordPresenterDTO?) {
        screen.categoryLabel.setText(word?.category)
        screen.initialQuestionLabel.setText(word?.initialQuestion)
        configHangmanLettersInWord(word)
        configPositionLettersOfWord(word)
        configQuantityLetter(word?.word?.count)
    }
    
    private func configQuantityLetter(_ qtd: Int?) {
        screen.countCorrectLetterLabel.setText("0/\(qtd ?? 0)")
    }
        
    private func configPositionLettersOfWord(_ word: NextWordPresenterDTO?) {
        guard let word else { return }
        
        let indexBreakLine = identifierBreakLine(word)
        
        lettersInWord.enumerated().forEach({ index, letter in
            if index <= indexBreakLine {
                guard let letter else { return insertSpaceInStack(screen.gallowsWordView.horizontalStack1) }
                addLetterStackHorizontal1(letter)
                return
            }
            guard let letter else { return insertSpaceInStack(screen.gallowsWordView.horizontalStack2) }
            addLetterStackHorizontal2(letter)
        })
    }
    
    private func identifierBreakLine(_ word: NextWordPresenterDTO?) -> Int {
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
        insertLetterInStack(letter, screen.gallowsWordView.horizontalStack1)
    }
    
    private func addLetterStackHorizontal2(_ letter: HangmanLetterInWordView) {
        if screen.gallowsWordView.horizontalStack2.get.isHidden {
            screen.gallowsWordView.horizontalStack2.setHidden(false)
        }
        insertLetterInStack(letter, screen.gallowsWordView.horizontalStack2)
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
    
    private func configHangmanLettersInWord(_ word: NextWordPresenterDTO?) {
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
        let buttonInteration = ButtonInteractionBuilder(button: button).setColor(color)
        buttonInteration.pressed
    }
    
    private func revealLetters(_ indexes: [Int], color: UIColor) {
        indexes.forEach { index in
            lettersInWord[index]?.label.setHidden(false)
            lettersInWord[index]?.gradient?.setReferenceColor(color, percentageGradient: 10)
                .setAxialGradient(.rightToLeft)
                .apply()
        }
    }

        
//  MARK: - RESET ELEMENTS
    
    private func resetElements() {
        resetGallowsWordView()
    }
    
    private func resetGallowsWordView() {
        screen.gallowsWordView.resetStackView()
        lettersInWord.removeAll()
    }
   
}


//  MARK: - EXTENSION - HangmanKeyboardViewDelegate

extension HomeViewController: HangmanViewDelegate {
    
    func nextWordButtonTapped() {
        resetElements()
        homePresenter.getNextWord()
    }
    
}


//  MARK: - EXTENSION - HangmanKeyboardViewDelegate

extension HomeViewController: HangmanKeyboardViewDelegate {
    
    func letterButtonTapped(_ button: UIButton) {
        homePresenter.verifyMatchInWord(button.titleLabel?.text)
    }
    
    func moreTipTapped() {
        print(#function)
    }
    
    
}


//  MARK: - EXTENSION - ProfileSummaryPresenterOutput

extension HomeViewController: ProfileSummaryPresenterOutput {
    public func statusChosenLetter(isCorrect: Bool, _ keyboardLetter: String) {
        let tag = K.Keyboard.letter[keyboardLetter.uppercased()] ?? 0
        guard let button = screen.gallowsKeyboardView.get.viewWithTag(tag) as? UIButton else { return }
        button.removeNeumorphism()
        if isCorrect {
            updateKeyboardLetterSuccess(button)
            return
        }
        updateKeyboardLetterError(button)
    }
    
    public func revealCorrectLetter(_ indexes: [Int]) {
        revealLetters(indexes, color: Theme.shared.currentTheme.primary.withAlphaComponent(0.4))
    }
    
    public func revealLetterEndGame(_ indexes: [Int]) {
        revealLetters(indexes, color: Theme.shared.currentTheme.error.withAlphaComponent(0.5))
    }
        
    public func updateCountCorrectLetters(_ count: String) {
        screen.countCorrectLetterLabel.setText(count)
    }
    
    public func successFetchNextWord(nextWord: NextWordPresenterDTO?) {
        configNextWord(nextWord)
    }
    
    public func nextWordIsOver(title: String, message: String) {
        print(message)
    }
    
    public func errorFetchNextWords(title: String, message: String) {
        print(message)
    }
    
    
}
