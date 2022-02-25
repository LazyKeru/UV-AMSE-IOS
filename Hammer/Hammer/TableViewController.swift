//
//  TableViewController.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController: NSFetchedResultsControllerDelegate {
    
}
