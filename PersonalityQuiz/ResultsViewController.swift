//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Jeremy Jackman on 2/21/22.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var responses: [Answer]!
    //Answer Label
    @IBOutlet weak var resultAnswerLabel: UILabel!
    // Definition Label
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        let responseType = responses.map { $0.type }
        
        for response in responseType {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
    }
        let frequentAnswersSorted = frequencyOfAnswers.sorted { (pair1, pair2) -> Bool in
            
            return pair1.value > pair2.value
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted {$0.1 > $1.1}.first!.key
        
        resultAnswerLabel.text = "YOU ARE A \(mostCommonAnswer.rawValue)"
        resultDefinitionLabel.text = mostCommonAnswer.definition



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    }
}
