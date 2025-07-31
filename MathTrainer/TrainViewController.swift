//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Mariia on 12.07.2025.
//

import UIKit

final class TrainViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    private var firstNum: Int = 0
    private var secondNum: Int = 0
    
    private var sign: String = ""
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .divide:
                sign = "/"
            case .multiply:
                sign = "*"
            case .subtract:
                sign = "-"
            }
            
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNum + secondNum
        case .subtract:
            return firstNum - secondNum
        case .multiply:
            return firstNum * secondNum
        case .divide:
            return firstNum / secondNum
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configureScoreLabel(type)
        configureQuestion()
        configureButtons()
    }
    
    @IBAction func rightAction(_ sender: UIButton) {
        checkAnswer(sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func leftAction(_ sender: UIButton) {
        checkAnswer(sender.titleLabel?.text ?? "", for: sender)
    }
    
    private func configureButtons() {
        let buttonsArray: [UIButton] = [ leftButton, rightButton ]
        
        buttonsArray.forEach{ button in
            button.backgroundColor = .systemYellow
        }
        
        buttonsArray.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 1)...(answer + 1))
        } while randomAnswer == answer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        if sign == "/" {
            let result = Int.random(in: 2...12)
            secondNum = Int.random(in: 2...12)
            firstNum = result * secondNum
        } else {
            firstNum = Int.random(in: 1...99)
            secondNum = Int.random(in: 1...99)
        }
        
        let answer: String = "\(firstNum) \(sign) \(secondNum)"
        questionLabel.text = answer
    }
    
    private func configureScoreLabel(_ type: MathTypes) {
        let scoreData = ScoreManager.shared.getScore(type)
        scoreLabel.text = "Score: \(String(scoreData))"
    }
    
    private func checkAnswer(_ answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            ScoreManager.shared.addPoint(type)
            self.configureScoreLabel(self.type)
        }
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            self.configureQuestion()
            self.configureButtons()
        }
    }
}
