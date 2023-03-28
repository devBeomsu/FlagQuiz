//
//  GameViewController.swift
//  FlagQuiz
//
//  Created by Raphael Shim on 2023/03/27.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    // Properties
    var flags: [Flag] = Flag.flags // Flag 인스턴스의 배열, 게임에서 사용할 국기 이미지와 국가 이름이 들어있음
    var correctAnswer = 0 // 정답 국기 이미지가 있는 'flags' 배열의 인덱스를 저장할 변수
    var score = 0 // 현재 플레이어의 점수를 저장할 변수
    var displayedImages = [Int]() // 이미 나온 국기 이미지의 인덱스를 저장할 배열
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askQuestion() // 뷰가 로드될 때 첫 번째 질문을 물음
    }
    
    // 랜덤 국기 이미지를 가진 질문을 표시
    func askQuestion() {
        if flags.count > 0 {
            // 표시되지 않은 이미지 중 랜덤으로 선택하기 위한 숫자 생성
            var randomImage = Int.random(in: 0..<flags.count)
            while displayedImages.contains(randomImage) {
                randomImage = Int.random(in: 0..<flags.count)
            }
            displayedImages.append(randomImage)
            correctAnswer = randomImage
            let imageName = flags[randomImage].image // `randomImage` 인덱스에 있는 `Flag` 인스턴스에서 이미지 이름 가져오기
            flagImageView.image = UIImage(named: imageName) // 선택한 이미지로 이미지 뷰의 이미지 설정
        } else {
            // 모든 국기 이미지를 표시한 경우, 종료 뷰 컨트롤러를 표시
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let endViewController = storyboard.instantiateViewController(withIdentifier: "EndViewController") as! EndViewController
            endViewController.score = score // 플레이어의 최종 점수를 종료 뷰 컨트롤러로 전달
            // 종료 버튼을 탭했을 때 처리하기 위한 핸들러
            endViewController.restartHandler = {
                self.score = 0 // 점수 리셋
                self.scoreLabel.text = "\(self.score)" // 점수 레이블 업데이트
                self.flags = Flag.flags // 국기 이미지 배열 리셋
                self.displayedImages = [] // 이미지 인덱스 배열 리셋
                self.askQuestion() // 첫 번째 질문 다시 묻기
                endViewController.dismiss(animated: true, completion: nil) // 종료 뷰 컨트롤러 닫기
            }
            endViewController.modalPresentationStyle = .fullScreen // 종료 뷰 컨트롤러를 전체 화면으로 표시
            present(endViewController, animated: true, completion: nil) // 종료 뷰 컨트롤러 모달로 표시
        }
    }
    
    func checkAnswer() {
        // textField에서 사용자가 입력한 답을 가져옴
        if let answerText = textField.text {
            var title: String
            // 사용자가 입력한 답과 정답을 비교
            if answerText == flags[correctAnswer].name {
                // 정답이면 "Correct"로 타이틀을 설정하고 점수를 1점 증가시킴
                title = "Correct"
                score += 1
            } else {
                // 오답이면 "Wrong"으로 타이틀을 설정하고 점수를 1점 감소시킴
                title = "Wrong"
                score -= 1
            }
            // 화면에 점수를 표시
            scoreLabel.text = "\(score)"
            // 점수가 0보다 작아지면 게임이 끝나게 됨
            if score < 0 {
                // EndViewController를 생성하고 점수와 재시작 핸들러를 전달
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let endViewController = storyboard.instantiateViewController(withIdentifier: "EndViewController") as! EndViewController
                endViewController.score = score
                endViewController.restartHandler = {
                    // 재시작 핸들러를 실행하면 게임 데이터를 초기화하고 새로운 게임을 시작함
                    self.score = 0
                    self.scoreLabel.text = "\(self.score)"
                    self.flags = Flag.flags
                    self.displayedImages = []
                    self.askQuestion()
                    endViewController.dismiss(animated: true, completion: nil)
                }
                
                // EndViewController를 전체화면으로 모달 표시
                endViewController.modalPresentationStyle = .fullScreen
                present(endViewController, animated: true, completion: nil)
                // 점수가 0보다 크고 아직 출제할 국기가 남아있으면 다음 문제를 출제함
            } else if flags.count > 0 {
                // UIAlertController를 생성하여 타이틀을 표시하고 "Continue" 버튼을 추가함
                let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                    // 다음 문제를 출제하기 위해 출제된 국기와 이미지를 삭제하고 textField를 초기화함
                    self.flags.remove(at: self.correctAnswer)
                    self.displayedImages = []
                    self.askQuestion()
                    self.textField.text = ""
                }))
                // UIAlertController를 표시함
                present(alertController, animated: true)
                // 점수가 0보다 크고 출제할 국기가 없으면 모든 문제를 다 풀었으므로 게임을 재시작함
            } else {
                askQuestion()
            }
        }
    }
    
    // "Submit" 버튼이 탭되면 키보드를 닫고 checkAnswer() 함수를 호출함
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
        checkAnswer()
    }
}
