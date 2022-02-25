//
//  TableViewController.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    @IBAction func retour(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chargerDonnees()
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let joueurs = fetchedResultsController.fetchedObjects else { return 0 }
        return joueurs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementatsion, return the number of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluleJeu", for: indexPath )
        let joueur = fetchedResultsController.object(at: indexPath) as Joueurs
        cell.textLabel?.text = joueur.nom
        cell.detailTextLabel?.text = joueur.prenom
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle , forRowAt indexPath : IndexPath ) {
        if editingStyle == . delete {
            let managedObjectContext : NSManagedObjectContext = ( UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let managedObject : NSManagedObject = fetchedResultsController.object ( at : indexPath ) as NSManagedObject
            managedObjectContext.delete ( managedObject ) ;
            do {
                try managedObjectContext . save () ;
            }
            catch {
        // Traitement Erreur . . .
            }
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

    // ScoreView
    
    var estAppeleeParSelection = false
    var appelant : UIViewController?
    var JoueurEnCours : Joueurs?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.estAppeleeParSelection) {
            ( self.appelant as! ViewController ).joueurAAssigner =
            fetchedResultsController.object(at: indexPath) as Joueurs
                self.dismiss(animated: true, completion: nil)
            (self.appelant as! ViewController).saveScore ()
        }
        else {
            JoueurEnCours = fetchedResultsController.object(at: indexPath) as Joueurs
            self.performSegue(withIdentifier: "segueDetail", sender: self)
        }
    }

}

extension TableViewController: NSFetchedResultsControllerDelegate {
    
}
