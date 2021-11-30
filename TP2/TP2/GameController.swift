//
//  ViewController.swift
//  TP2
//
//  Created by user206378 on 11/30/21.
//

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

import UIKit

class GameController: UIViewController {
    
    var life : Int = 6
    var totalWidth : Int = 0
    var wordToGuess : String = "Patate".lowercased()
    
    let LETTER_SPACING : Int = 3
    let LETTER_WIDTH : Int = 15

    @IBOutlet weak var wordStackView: UIStackView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage(named: "hangman" + String(life))
        
        let wordLength : Float32 = Float32((wordToGuess.count * LETTER_WIDTH) + ((wordToGuess.count - 1) * LETTER_SPACING))
        let firstLabelPosX : Float32 = (Float32(UIScreen.main.bounds.width) - wordLength) / 2
        totalWidth = Int(firstLabelPosX)
        
        for _ in wordToGuess {
            let label = UILabel(frame: CGRect(x: totalWidth, y: 0, width: LETTER_WIDTH, height: 20))
            label.textAlignment = .center
            label.text = "_"
            
            totalWidth += LETTER_WIDTH
            
            wordStackView.addSubview(label)
        }
    }


    @IBAction func letterPress(_ sender: Any) {
        let button = sender as! UIButton
        let letter = button.titleLabel?.text
        
        if (wordToGuess.contains(letter!)) {
            updateWordView(letter: Character(letter!))
        } else {
            subLife()
        }
        
        button.isEnabled = false
    }
    
    func subLife() {
        life -= 1
        imgView.image = UIImage(named: "hangman" + String(life))
        
        if (life == 0) {
            print("T MOOOOOOOOOORT")
        }
    }
    
    func updateWordView(letter : Character) {
        var i : Int = 0
        wordStackView.subviews.forEach { viewElem in
            let label = viewElem as! UILabel
            if wordToGuess[i] == letter {
                label.text = String(letter)
            }
            i += 1
        }
        
        // Checkwin
        if (playerGuessedAllTheLetters()) {
            print("BRAVOOOOOOOOOOOO")
        }
    }
    
    func playerGuessedAllTheLetters() -> Bool {
        var flag : Bool = true
        let views = wordStackView.subviews
        
        checkWinLoop : for viewElem in views {
            let label = viewElem as! UILabel
            if (label.text == "_") {
                flag = false
                break checkWinLoop
            }
        }
        return flag
    }
}

