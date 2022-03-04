//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Jeremy Jackman on 2/21/22.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    //singleStackView - As Seen in View
    @IBOutlet weak var singleStackView: UIStackView!
    //Each of the Buttons
    
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    //multipleStackView - As seen in View
    @IBOutlet weak var multipleStackView: UIStackView!
    //Each of the Label
    
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    //Each of Label Switch
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    //rangedStackView
    @IBOutlet weak var rangedStackView: UIStackView!
    
    //rangedSlider
    @IBOutlet weak var rangedSlider: UISlider!
    //Ranged Label
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    //Progress View (Bottom)
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
     
    var questions: [Question] = [
    Question(
        text: "Which food do you like the most?",
        type: .single,
        answers: [
            Answer(text: "Steak 🥩", type: .dog),
            Answer(text: "Fish 🍤", type: .cat),
            Answer(text: "Carrot 🥕", type: .rabbit),
            Answer(text: "Corn 🌽", type: .turtle),
        ]
    ),
    
    Question(
        text: "Which acivities do you enjoy?",
        type: .multiple,
        answers: [
            Answer(text: "Swimming 🏊", type: .turtle),
            Answer(text: "Sleeping 😴", type: .cat),
            Answer(text: "Cuddling 🧑‍🍼", type: .rabbit),
            Answer(text: "Eating 🍽 ", type: .dog),
        ]
    ),
    
    Question(
        text: "How much do you enjoy car rides?",
        type: .ranged,
        answers: [
            Answer(text: "I dislike them. 😡", type: .cat),
            Answer(text: "I get a little nervous. 😬", type: .rabbit),
            Answer(text: "I barely notice them. 😕", type: .turtle),
            Answer(text: "I LOVE them! 😊", type: .dog),
            ])
    
    ]
    // All Variables
    var questionIndex = 0
    
    var answersChosen: [Answer] = []
    
    
    @IBAction func singleAnsweButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
            
        case singleButton2:
            answersChosen.append(currentAnswers[1])
            
        case singleButton3:
            answersChosen.append(currentAnswers[2])
            
        case singleButton4:
            answersChosen.append(currentAnswers[3])
            
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    //SubmitButton
    
   
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1 
        
        if questionIndex < questions.count{
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
        
    }
    func updateUI () {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Questions #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        switch currentQuestion.type {
        case.single:
            singleStackView.isHidden = false
            updateSingleStack(using: currentAnswers)
        case .multiple:
            multipleStackView.isHidden = false
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            rangedStackView.isHidden = false
            updateRangedStackView(using: currentAnswers)
        }
        
    }

    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        //multi switch
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        // multi label
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
