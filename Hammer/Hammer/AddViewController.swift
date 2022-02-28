//
//  AddViewController.swift
//  Hammer
//
//  Created by admin on 28/02/2022.
//

import UIKit
import CoreData

class AddViewController: UIViewController {

    var appelant: TableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var n : UITextField?
    @IBOutlet var p : UITextField?
    
    @IBAction func ok(_ sender : UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let j: Joueurs = NSEntityDescription.insertNewObject(forEntityName: "Joueurs", into:
                                                                managerContext ) as! Joueurs
        j.nom = n?.text
        j.prenom = p?.text
        j.ensembleDesScores = nil
        do {
            try managerContext.save ()
            print ("Ajout␣ok")
        } catch {
            let fetchError = error as NSError
            print ("Impossible d’ajouter")
            print ("\(fetchError) , \(fetchError.localizedDescription)")
    }
        appelant?.viewDidLoad()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
extension AddViewController: NSFetchedResultsControllerDelegate {
}
