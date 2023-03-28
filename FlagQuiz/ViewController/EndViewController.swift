//
//  EndViewController.swift
//  FlagQuiz
//
//  Created by Raphael Shim on 2023/03/28.
//

import UIKit

class EndViewController: UIViewController {
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    var score = 0
    var restartHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if score >= 0 {
            totalScoreLabel.text = "\(score)"
        } else {
            totalScoreLabel.text = "Game Over"
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        restartHandler?()
    }
    
    @IBAction func goHomeButtonTapped(_ sender: UIButton) {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            window.rootViewController = homeViewController
        }
    }
}
