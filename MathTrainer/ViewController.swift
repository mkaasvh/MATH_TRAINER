//
//  ViewController.swift
//  MathTrainer
//
//  Created by Mariia on 12.07.2025.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    @IBOutlet var buttonsCollection: [UIButton]!
    
    private var selectedType: MathTypes = .add
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureButtons()
    }
    
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToTheNextPage", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
    
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
}

