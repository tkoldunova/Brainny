//
//  LoaderViewController.swift
//  Brainny
//
//  Created by Tanya Koldunova on 01.12.2024.
//

import UIKit
import Lottie

class LoaderViewController: BaseViewController<LoaderPresenterProtocol>, LoaderViewProtocol {
    
    @IBOutlet weak var guestionMarkImageView: UIImageView!
    @IBOutlet var dynamicQuestionImageViews: [UIImageView]!
    @IBOutlet weak var progressView: ProgreeView! {
        didSet {
            progressView.delegate = presenter
        }
    }
    @IBOutlet weak var lottieContainerView: UIView! {
        didSet {
            lottieContainerView.addSubview(lottieAnimationView)
            lottieAnimationView.fillSuperview()
        }
    }
    lazy var lottieAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "brain")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpGradient()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.notifyWhenViewWillApear()
    }
    
    
    func playAnimations() {
        self.lottieAnimationView.play()
        dynamicQuestionImageViews.forEach { imgView in
            var rotationAndPerspectiveTransform = CATransform3DIdentity
            rotationAndPerspectiveTransform.m34 = -1.0 / 1000.0
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? Double.pi * 1 : -Double.pi, 0, 1, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? 0.1 : -0.1)
            var rotationAndPerspectiveTransform2 = CATransform3DIdentity
            rotationAndPerspectiveTransform2.m34 = 1.0 / 1000.0
            rotationAndPerspectiveTransform2 = CATransform3DRotate(rotationAndPerspectiveTransform, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? -Double.pi * 1 : Double.pi, 0, 1, (dynamicQuestionImageViews.firstIndex(of: imgView) ?? 0)%2 == 0 ? -0.1 : 0.1)
            UIView.animateKeyframes(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse]) {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                    imgView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    imgView.layer.transform = rotationAndPerspectiveTransform
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                    imgView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                    imgView.layer.transform = rotationAndPerspectiveTransform2
                })
            }
        }
    }
    
    func playAnimation(duration: TimeInterval) {
        progressView.animate(duration: duration)

    }

}
