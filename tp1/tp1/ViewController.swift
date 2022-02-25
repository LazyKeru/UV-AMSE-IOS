//
//  ViewController.swift
//  tp1
//
//  Created by admin on 25/02/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // deisgne un element d'interface graphique
    @IBOutlet weak var textTitre: UILabel!;
    // weak dans le type de var veux dire que la gestion mémoire de la variable est faite ailleurs
    @IBOutlet weak var zoneSaisie: UITextField!; // "!" car la var n'est pas encore créé

    // deisgne une methode associé à un événement graphique
    @IBAction func boutonLancer(_ sender : UIButton){
        
    }
    
    @IBAction func boutonCacher(_ sender : UIButton){
        if sender.currentTitle == "Cacher" {
            textTitre.isHidden = true
            zoneSaisie.isHidden = true
            sender.setTitle("Montrer", for: .normal)
        }else{
            textTitre.isHidden = false
            zoneSaisie.isHidden = false
            sender.setTitle("Cacher", for: .normal)
        }
    }
        
    

}

