//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Mariia on 12.07.2025.
//

import UIKit

final class TrainViewController: UIViewController {
    @IBOutlet var buttonsCollection: [UIButton]!
    
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    
    private func configureButtons() {
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}
