//
//  ViewController.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//

import UIKit
import CoreMotion
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var motionManager : CMMotionManager!
    var timer: Timer!
    var nbVal: Int = 0
    var donnees: [Double] = []
    var score : Double = 0.0
    var score2 : Double = 0.0
    var joueurAAssigner : Joueurs?
    @IBOutlet var message : UILabel?
    @IBOutlet var boutonGo : UIButton?
    @IBOutlet var boutonScores : UIButton?
    @IBOutlet var slider1 : UISlider?
    @IBOutlet var slider2 : UISlider?
    
    @IBAction func GoGoGo(_ sender : UIButton) {
        nbVal = 0
        motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates ()
        donnees = [Double](repeating: 0, count: 500)
    // ici : décoration pour faire une jolie animation avec des chiffres
    // possiblement parler : classe AVSpeechVoiceSynthesis : https :// developer . apple .com/documentation/avfaudio/avspeechsynthesisvoice
    boutonGo?.isEnabled = false
    boutonScores?.isEnabled = false
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self , selector: #selector(mesureDonnees) , userInfo : nil , repeats : true)
    }
    
    
    @objc func mesureDonnees(timer: Timer) {
        if(nbVal >= 500) {
            motionManager.stopAccelerometerUpdates ()
            timer.invalidate ()
            motionManager = nil
            self.calculScore ()
            boutonGo?.isEnabled = true
            boutonScores?.isEnabled = true
            self.performSegue(withIdentifier: "segueSelectionJoueur", sender: self)
        }else {
            if(motionManager == nil) {
                return
            }
            //donnees[nbVal] = sqrt(motionManager.accelerometerData!.acceleration.x ∗ motionManager.accelerometerData!.acceleration.x + motionManager. accelerometerData!.acceleration.y ∗ motionManager.accelerometerData!. acceleration.y + motionManager.accelerometerData!.acceleration.z ∗ motionManager . a c c e l e r o m e t e r D a t a ! . a c c e l e r a t i o n . z )
            //attention sur simulateur , accelerometerData est nil ...
            print("Acquisition_:_\(nbVal)")
            nbVal += 1
        }
    }
    
    func calculScore(){
        // Calcul de votre score en fonction du max ou de la moyenne de votre tableau " donnees"
        // Affectation dans la variable score ...
        score = 10
    }
}

