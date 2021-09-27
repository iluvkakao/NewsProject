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
    
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimation()
    }
    
    //viewdidAppear
    private func setupAnimation(){
        animationView.animation = Animation.named("news-app-preloader")
        animationView.frame = view.bounds
        animationView.center = view.center
        animationView.backgroundColor = .black
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView )
        
        animationView.play { [weak self] success in
            self?.nextController()
        }
      
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

