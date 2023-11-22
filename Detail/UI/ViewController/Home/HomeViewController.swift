//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Presenter

public class HomeViewController: UIViewController {

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
        configCategory(word?.category)
        configInitialQuestion(word?.initialQuestion)
        configPositionLettersOfWord(word)
    }
    
    private func configCategory(_ category: String?) {
        screen.categoryLabel.setText(category)
    }
    
    private func configInitialQuestion(_ question: String?) {
        screen.initialQuestionLabel.setText(question)
    }
    
    private func configPositionLettersOfWord(_ word: NextWordPresenterDTO?) {
        guard let word else { return }
        
        let indexBreakLine = identifierBreakLine(word)
        
        word.syllables?.enumerated().forEach({ index, syllable in
            if index <= indexBreakLine {
                addLetterStackHorizontal1(syllable)
                return
            }
            addLetterStackHorizontal2(syllable)
        })
        
        
    }
    
    private func identifierBreakLine(_ word: NextWordPresenterDTO?) -> Int {
        var indexBreakLine = K.quantityLetterByLine
        
        guard let word, let syllables = word.syllables else { return indexBreakLine }
        
        if word.word?.count ?? 0 <= K.quantityLetterByLine { return indexBreakLine }
    
        var acumulator = ""
        for (index, syllable) in syllables.enumerated() {
            acumulator += syllable
            if acumulator.count > K.quantityLetterByLine {
                indexBreakLine = index - 1
                break
            }
        }
        return indexBreakLine
    }
    
    private func addLetterStackHorizontal1(_ letters: String) {
        letters.uppercased().forEach { letter in
            insertLetterInStack(createLetter(letter.description), screen.gallowsWordView.horizontalStack1)
        }
    }
    
    private func addLetterStackHorizontal2(_ letters: String) {
        if screen.gallowsWordView.horizontalStack2.get.isHidden {
            screen.gallowsWordView.horizontalStack2.setHidden(false)
        }
        letters.uppercased().forEach { letter in
            insertLetterInStack(createLetter(letter.description), screen.gallowsWordView.horizontalStack2)
        }
    }
    
    private func insertLetterInStack(_ letter: HangmanLetterInWordView, _ horizontalStack: StackViewBuilder) {
        letter.add(insideTo: horizontalStack.get)
        letter.applyConstraint()
    }
    
    private func createLetter(_ text: String) -> HangmanLetterInWordView {
        let letter = HangmanLetterInWordView(text)
            .setConstraints { build in
                build
                    .setWidth.equalToConstant(22)
                    .setHeight.equalToConstant(26)
            }
        return letter
    }
    
    private func resetElements() {
        resetGallowsWordView()
    }
    
    func resetGallowsWordView() {
        screen.resetGallowsWordView()
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
        print(#function)
    }
    
    func moreTipTapped() {
        print(#function)
    }
    
    
}


//  MARK: - EXTENSION - ProfileSummaryPresenterOutput

extension HomeViewController: ProfileSummaryPresenterOutput {
    
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
