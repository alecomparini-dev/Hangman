//  Created by Alessandro Comparini on 14/11/23.
//


import UIKit

import Presenter

public class HomeViewController: UIViewController {

    private let homePresenter: HomePresenter
    
    public init(homePresenter: HomePresenter) {
        self.homePresenter = homePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var screen: HomeView = {
        let comp = HomeView(frame: .zero)
        return comp
    }()
    
    
//  MARK: - LIFE CICLE
    
    public override func loadView() {
        view = screen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createNextWord()
    }
    
    
    
//  MARK: - PRIVATE AREA
    
    private func createNextWord() {
        positionLetters()
    }
    
    private func positionLetters() {
        let indexToBreakLine = calculateIndexToBreakLine()
        
        screen.gallowsWordView.createWord("ALESSANDRO LUIZ PEIXOTO").enumerated().forEach { index,letter in
            if index < indexToBreakLine { return addLetterStackHorizontal1(letter) }
            addLetterStackHorizontal2(letter)
        }
        
    }
    
    private func calculateIndexToBreakLine() -> Int {
//        if getCurrentWord().word.count <= quantityLetterByLine {return quantityLetterByLine}
//        let syllabesWord = getCurrentWord().syllables
        let syllabesWord = ["A","L","E","A","A","A","A","A","A","A", "", "A","A","A","A","A","A", "" ]
        
        let indexToBreakLine = syllabesWord.reduce(0) { partialResult, syllabe in
            let result = partialResult + syllabe.count
            guard result <= K.quantityLetterByLine else {
                return partialResult
            }
            return result
        }
        return indexToBreakLine
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



