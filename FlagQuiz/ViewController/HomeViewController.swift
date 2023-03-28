//
//  HomeViewController.swift
//  FlagQuiz
//
//  Created by Raphael Shim on 2023/03/27.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.window?.rootViewController = self
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let gameViewController = self.storyboard?.instantiateViewController(identifier: "GameViewController")
        gameViewController?.modalPresentationStyle = .fullScreen
        gameViewController?.modalTransitionStyle = .flipHorizontal
        self.present(gameViewController!, animated: true, completion: nil)
    }
}
