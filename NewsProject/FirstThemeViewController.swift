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
}

