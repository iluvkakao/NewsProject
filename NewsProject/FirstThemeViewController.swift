//
//  FirstThemeViewController.swift
//  NewsProject
//
//  Created by Natallia Askerka on 5.09.21.
//

import UIKit
import Lottie

final class FirstThemeViewController: UIViewController {
    
    let animationView = AnimationView()
      

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupAnimation()
        let secondsToDelay = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
            self.nextController()
            
        }
     
    }

    private func setupAnimation(){
        animationView.animation = Animation.named("news-app-preloader")
        animationView.frame = view.bounds
        animationView.backgroundColor = .black
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView )
    }
    
    private func nextController(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let controller = storyBoard.instantiateViewController(withIdentifier: "ViewController")
                            let navigation = UINavigationController(rootViewController: controller)
                            navigation.modalPresentationStyle = .fullScreen
        
        
                            let window = UIApplication.shared.windows.first
                            window?.replaceRootViewControllerWith(navigation, animated: true, completion: nil)
     
    }
    

//    @IBOutlet private weak var firstImage: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        startAnimation()
//    }
//
//    private func startAnimation() {
//            UIView.animate(
//                withDuration: 1.4,
//                delay: 0,
//                usingSpringWithDamping: 0.1,
//                initialSpringVelocity: 1.5,
//                options: [.curveEaseOut],
//                animations: { [weak self] in
//                    self?.firstImage.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//                    self?.firstImage.alpha = 1
//
//            }, completion: { _ in
//                UIView.animate(withDuration: 0.5, delay: 0.05, options: .curveEaseIn) { [weak self] in
//                    self?.firstImage.transform = CGAffineTransform(scaleX: 8, y: 8)
//                    self?.firstImage.alpha = 0.3
//                    self?.firstImage.alpha = 0.1
//
//                } completion: { [weak self] _ in
//                    self?.firstImage.alpha = 0
//                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                    let controller = storyBoard.instantiateViewController(withIdentifier: "ViewController")
////                       as? ViewController
//
//
//
//                    let navigation = UINavigationController(rootViewController: controller)
//                    navigation.modalPresentationStyle = .fullScreen
//
//
//                    let window = UIApplication.shared.windows.first
//                    window?.replaceRootViewControllerWith(navigation, animated: true, completion: nil)
//
//
//
//                }
//            })
//
//        }
}

