//
//  RulesLeaderViewController.swift
//  Hammer
//
//  Created by admin on 01/03/2022.
//

import UIKit
import CoreMotion
import CoreData

class RulesLeaderViewController: UIViewController {
    @IBOutlet var name1 : UILabel?
    @IBOutlet var score1 : UILabel?
    @IBOutlet var name2 : UILabel?
    @IBOutlet var score2 : UILabel?
    @IBOutlet var name3 : UILabel?
    @IBOutlet var score3 : UILabel?
    
    @IBAction func retour(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chargerDonnees()
        maxScore ()
        // Do any additional setup after loading the view.
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
        var _maxScore : [Double] = [0, 0, 0]
        var _maxName : [String] = ["Empty", "Empty", "Empty"]
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
                innerloop: for _k in 0..._maxScore.count-1{
                        if _score.score > _maxScore[_k] {
                            _maxScore[_k] = _score.score
                            _maxName[_k] = _joueur.nom!
                            break innerloop
                        }
                    }
                }
            }
        }
        name1?.text = _maxName[0];
        score1?.text = String(_maxScore[0]);
        name2?.text = _maxName[1];
        score2?.text = String(_maxScore[1]);
        name3?.text = _maxName[2];
        score3?.text = String(_maxScore[2]);
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

extension RulesLeaderViewController: NSFetchedResultsControllerDelegate {
    
}
