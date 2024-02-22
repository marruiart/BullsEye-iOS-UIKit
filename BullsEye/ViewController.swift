//
//  ViewController.swift
//  BullsEye
//
//  Created by Marina on 21/2/24.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    @IBOutlet weak var slider: UISlider!
    var targetValue = 0
    @IBOutlet weak var targetLabel: UILabel!
    var score = 0
    @IBOutlet weak var scoreLabel: UILabel!
    var round = 0
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewRound()
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func updateScore(_ points: Int) {
        score += points
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }

    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference + applyBonus(difference)
        let title: String = getTitle(difference)
        updateScore(points)
        
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion:nil)
    }
    
    func getTitle(_ difference: Int) -> String {
        if difference == 0 {
            return "Perfect!"
        } else if difference < 5 {
            return "You almost had it!"
        } else if difference < 10 {
            return "Pretty good!"
        } else{
            return "Not even close..."
        }
    }
    
    func applyBonus(_ difference: Int) -> Int {
        switch difference {
        case 0:
            return 100
        case 1:
            return 50
        default:
            return 0
        }
    }
}
