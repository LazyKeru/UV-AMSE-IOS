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
        chargerDonnees()
        maxScore ()
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
        while(motionManager.accelerometerData == nil){
            print("MotionManager has not started. Please be better apple")
        }
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
            
            donnees[nbVal] = sqrt(motionManager.accelerometerData!.acceleration.x *
                                  motionManager.accelerometerData!.acceleration.x +
                                  motionManager.accelerometerData!.acceleration.y *
                                  motionManager.accelerometerData!.acceleration.y +
                                  motionManager.accelerometerData!.acceleration.z *
                                  motionManager.accelerometerData!.acceleration.z )
            //attention sur simulateur , accelerometerData est nil ...
            print("Acquisition : \(nbVal)")
            nbVal += 1
        }
    }
    
    func calculScore(){
        // Calcul de votre score en fonction du max ou de la moyenne de votre tableau " donnees"
        // Affectation dans la variable score ...
        score = 0
        for donnee in donnees {
            score += donnee
        }
        score = score / Double(donnees.count)
    }
    
    override func prepare ( for segue : UIStoryboardSegue , sender : Any?) {
        if (segue . identifier == "segueSelectionJoueur") {
            ((segue.destination as! UINavigationController ).topViewController as! TableViewController).estAppeleeParSelection = true
            ((segue.destination as! UINavigationController ) . topViewController as! TableViewController).appelant = self
        }
    }
    
    func saveScore () {
        let max1: Double = sqrt(192) // Si 8g max par axe...
        if(score > 10) {
            message?.text = "ROI DES BIG BOSS"
        }
        else if(score > 5) {
            message?.text = "BIG BOSS"
        }
        else {
            message?.text = "SMALL BOSS"
        }
        slider1?.value = Float(score / max1)
        //slider2?.value = Float(score / max1)
        maxScore() // Max score called again to update. In case we beat the high score
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let s: Scores = NSEntityDescription.insertNewObject(forEntityName: "Scores",
        into: managerContext) as! Scores
        s.score = Double(score)
        s.date = Date()
        s.quelJoueur = joueurAAssigner
        if(joueurAAssigner?.ensembleDesScores == nil) {
            let setScores = NSSet.init(object:s)
            joueurAAssigner?.ensembleDesScores = setScores
        }
        else {
            joueurAAssigner?.addToEnsembleDesScores(s)
        }
        do {
            try managerContext.save()
            print("Ajout ok")
            print("score: \(s.score)")
            print("player name: \(String(describing: s.quelJoueur?.prenom))")
        } catch {
            let fetchError = error as NSError
            print("Impossible d’ajouter")
            print ("\( fetchError ),\(fetchError.localizedDescription)")
        }
    }
    
    let persistentContainer = NSPersistentContainer.init(name: "Hammer") // ici à remplacer par le nom de votre modèle
    
    lazy var fetchedResultsController: NSFetchedResultsController<Joueurs> = {
        let fetchRequest : NSFetchRequest<Joueurs> = Joueurs . fetchRequest ()
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "nom", ascending: false)]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchedResultsController = NSFetchedResultsController(fetchRequest : fetchRequest , managedObjectContext : managerContext , sectionNameKeyPath : nil , cacheName : nil )
        fetchedResultsController.delegate = self
        return fetchedResultsController
        
    }()
    
    func chargerDonnees(){
        persistentContainer.loadPersistentStores {
            (persistentStoreDescription , error) in
            if let error = error {
                print ("Unable_to_Load_Persistent_Store")
                print ("\( error ) ,_\( error . localizedDescription )")
            }
            else{
                do{
                    try self.fetchedResultsController.performFetch ()
                    
                }
                catch {
                    let fetchError = error as NSError
                    print ("Unable_to_Perform_Fetch_Request")
                    print ("\( fetchError ) ,_\( fetchError.localizedDescription )")
                }
            }
        }
    }
    
    func maxScore () {
        print("MaxScore Called")
        let _max1: Double = sqrt(192) // Si 8g max par axe...
        var _maxScore : Double = 0
        // Get the joueurs
        guard let _joueurs = fetchedResultsController.fetchedObjects else { return }
        print("Amount of player: \(_joueurs.count)")
        for _j in 0...(_joueurs.count-1) {
            let _joueur : Joueurs = fetchedResultsController.object(at: IndexPath(row: _j, section: 0)) as Joueurs
            let _ensembleScores:NSArray = _joueur.ensembleDesScores!.allObjects as NSArray
            print("Player: \(String(describing: _joueur.nom))")
            if(_joueur.ensembleDesScores != nil && _joueur.ensembleDesScores?.count != 0 ) {
                for _i in 0..._ensembleScores.count-1 {
                    let _score = _ensembleScores.object(at: _i) as! Scores
                    print("score \(_i): \(String(describing: _score.score))")
                    if _score.score > _maxScore { _maxScore = _score.score}
                }
            }
        }
        slider2?.value = Float(_maxScore / _max1);
    }
    
}

extension ViewController: NSFetchedResultsControllerDelegate {
    
} 
