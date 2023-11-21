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
        configure()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        configDelegate()
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
        guard let category else { return }
    }
    
    
    private func configInitialQuestion(_ question: String?) {
        guard let question else { return }
        
    }
    
    private func configPositionLettersOfWord(_ word: NextWordPresenterDTO?) {
        guard let word else { return }
        
    }
    
    
    private func positionLetters() {
        let indexToBreakLine = calculateIndexToBreakLine()
        
        screen.gallowsWordView.createWord("ALESSAND").enumerated().forEach { index,letter in
            if index < indexToBreakLine { return addLetterStackHorizontal1(letter) }
            addLetterStackHorizontal2(letter)
        }
        
    }
    
    
    
    
    
    
    
    private func calculateIndexToBreakLine() -> Int {
//        if getCurrentWord().word.count <= quantityLetterByLine {return quantityLetterByLine}
//        let syllabesWord = getCurrentWord().syllables
//        let indexToBreakLine = syllabesWord.reduce(0) { partialResult, syllabe in
//            let result = partialResult + syllabe.count
//            guard result <= K.quantityLetterByLine else {
//                return partialResult
//            }
//            return result
//        }
//        return indexToBreakLine
        return 0
    }
    
//    private func getCurrentWord() -> HangmanWord {
//        return hangmanWords[currentIndexPlayedWord]
//    }
    
    private func addLetterStackHorizontal1(_ letter: HangmanLetterInWordView) {
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack1)
    }
    
    private func addLetterStackHorizontal2(_ letter: HangmanLetterInWordView) {
        if screen.gallowsWordView.horizontalStack2.get.isHidden {
            screen.gallowsWordView.horizontalStack2.setHidden(false)
        }
        screen.gallowsWordView.insertLetterInStack(letter, screen.gallowsWordView.horizontalStack2)
    }
    
}



//  MARK: - EXTENSION - HangmanKeyboardViewDelegate

extension HomeViewController: HangmanViewDelegate {
    
    func nextWordButtonTapped() {
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
        
    }
    
    public func nextWordIsOver(title: String, message: String) {
        print(message)
    }
    
    public func errorFetchNextWords(title: String, message: String) {
        print(message)
    }
    
    
}
