//
//  File.swift
//  Hangman
//
//  Created by Alessandro Comparini on 12/01/24.
//

import UIKit
import CustomComponentsSDK

public protocol LoadScreenViewControllerCoordinator: AnyObject {
    func gotoHome()
}

public class LoadScreenViewController: UIViewController {
    public weak var coordinator: LoadScreenViewControllerCoordinator?
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    


//  MARK: - LAZY PROPERTIES
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var titleScreen: LabelBuilder = {
        let comp = LabelBuilder()
            .setText("HANGMAN")
            .setColor(hexColor: "#FFFFFF")
            .setWeight(.bold)
            .setSize(26)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(80)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()
    
    lazy var painelView: ViewBuilder = {
        let comp = ViewBuilder()
            .setAlpha(0)
            .setConstraints { build in
                build
                    .setTop.equalTo(titleScreen.get, .bottom, 48)
                    .setLeading.equalToSafeArea(16)
                    .setTrailing.equalToSafeArea(-16)
                    .setHeight.equalToConstant(200)
            }
        return comp
    }()
    
    lazy var gallowsView: GallowsView = {
        let comp = GallowsView()
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(13)
                    .setBottom.equalToSuperView(-18)
                    .setLeading.setTrailing.equalToSuperView
            }
        return comp
    }()
    
    lazy var dollImage: ImageViewBuilder = {
        let img = UIImage(named: "doll1")
        let comp = ImageViewBuilder(img)
            .setContentMode(.scaleAspectFit)
            .setConstraints { build in
                build
                    .setHorizontalAlignmentX.equalToSuperView(6)
                    .setBottom.equalToSuperView(-24)
                    .setWidth.equalToConstant(70)
                    .setHeight.equalToConstant(100)
            }
        return comp
    }()
    
    lazy var indicatorLoading: LoadingBuilder = {
        let comp = LoadingBuilder()
            .setColor(hexColor: "#FFFFFF")
            .setStyle(.medium)
            .setStartAnimating()
            .setConstraints { build in
                build
                    .setBottom.equalToSafeArea(-48)
                    .setHorizontalAlignmentX.equalToSafeArea
            }
        return comp
    }()

    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
        startAnimation()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self.view)
        titleScreen.add(insideTo: self.view)
        painelView.add(insideTo: self.view)
        gallowsView.add(insideTo: painelView.get)
        dollImage.add(insideTo: painelView.get)
        
        indicatorLoading.add(insideTo: self.view)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        titleScreen.applyConstraint()
        painelView.applyConstraint()
        gallowsView.applyConstraint()
        dollImage.applyConstraint()
        indicatorLoading.applyConstraint()
    }
    
    private func startAnimation() {
        
        UIView.animate(withDuration: 2, animations: { [weak self] in
            guard let self else { return }
            painelView.get.alpha = 1
        }) {  [weak self] bool in
            guard let self else { return }
            if bool {
                wavingAnimation()
            }
        }
    }
    
    private func wavingAnimation() {
        UIView.transition(with: dollImage.get, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self else { return }
            dollImage.get.image = UIImage(named: "doll2")
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: { [weak self] in
                guard let self else { return }
                UIView.transition(with: dollImage.get, duration: 0.5, options: .transitionCrossDissolve, animations: { [weak self] in
                    guard let self else { return }
                    dollImage.get.image = UIImage(named: "doll1")
                }) { [weak self] bool in
                    guard let self else { return }
                    if bool {
                        self.coordinator?.gotoHome()
                    }
                }
            })
            
            
        }
    }
    
}
