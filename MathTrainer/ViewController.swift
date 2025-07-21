//
//  ViewController.swift
//  MathTrainer
//
//  Created by Mariia on 12.07.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var addScoreLabel: UILabel!
    @IBOutlet weak var subtractScoreLabel: UILabel!
    @IBOutlet weak var multiplyScoreLabel: UILabel!
    @IBOutlet weak var divideScoreLabel: UILabel!
    
    private var selectedType: MathTypes = .add
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureButtons()
        configureLabels()
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToTheNextPage", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        configureLabels()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    private func configureLabels() {
        addScoreLabel.text = "scores: \(ScoreManager.shared.getScore(.add))"
        subtractScoreLabel.text = "scores: \(ScoreManager.shared.getScore(.subtract))"
        multiplyScoreLabel.text = "scores: \(ScoreManager.shared.getScore(.multiply))"
        divideScoreLabel.text = "scores: \(ScoreManager.shared.getScore(.divide))"
    }
}

