//
//  ScoreViewController.swift
//  Hammer
//
//  Created by admin on 25/02/2022.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBAction func retour(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var JoueurEnCours : Joueurs?
    
    @IBOutlet var textAAfficher : UILabel?
    
    var texte : String = ""
    
    override func viewDidLoad ( ) {
        super.viewDidLoad()
        afficherJoueur ()
        print("Loading ScoreViewController")
        print("JoueurEnCours Prenom: \(String(describing: JoueurEnCours?.prenom))")
        JoueurEnCours?.ensembleDesScores?.count
        print("JoueurEnCours nombre de score: \(JoueurEnCours?.ensembleDesScores?.count)")
        textAAfficher?.text = texte
    }
    
    func afficherJoueur () {
        if(JoueurEnCours == nil) {
            return
        }
        if(JoueurEnCours?.ensembleDesScores == nil || JoueurEnCours?.ensembleDesScores?.count == 0) {
            let j : Joueurs = JoueurEnCours!
            texte = "Aucun score pour le moment pour \(j.nom!) \(j.prenom!)"
            
        }
        else {
            let j : Joueurs = JoueurEnCours!
            let ensembleScores:NSArray = j.ensembleDesScores!.allObjects as NSArray
            texte = "Joueur \(j .nom!) \(j .prenom!) : "
            for index in 0 ..< ensembleScores.count-1 {
                let s = ensembleScores.object(at: index) as! Scores
                texte += "Le \(s.date!) −−> \(s.score) / "
            }
            let s = ensembleScores.object(at: ensembleScores.count-1) as! Scores
            texte += "Le \(s.date!) −−> \(s.score)."
            
        }
        print(texte)
        print ("ok") }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
