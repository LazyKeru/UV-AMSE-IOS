//
//  ViewController.swift
//  tp1
//
//  Created by admin on 25/02/2022.
//

import UIKit

class ViewController: UIViewController, UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // deisgne un element d'interface graphique
    @IBOutlet weak var textTitre: UILabel!;
    // weak dans le type de var veux dire que la gestion mémoire de la variable est faite ailleurs
    @IBOutlet weak var zoneSaisie: UITextField!; // "!" car la var n'est pas encore créé
    @IBOutlet weak var boutonLancer: UIButton!;
    @IBOutlet weak var segmentedControl: UISegmentedControl!;
    // deisgne une methode associé à un événement graphique
    @IBAction func boutonLancer(_ sender : UIButton){
        let  action1 = UIAlertAction ( title : "Done" , style: .default)
        let  action3 = UIAlertAction ( title : "Delete Text" , style: .destructive){
            (action: UIAlertAction) in self.zoneSaisie.text = ""
        }
        if segmentedControl.selectedSegmentIndex == 0 {
            let controler = UIAlertController (title : "Titre_du_message", message: zoneSaisie.text, preferredStyle: .alert)
            controler.addAction(action1)
            controler.addAction(action3)
            self.present(controler,animated: true, completion: nil)
        }else{
            let controler = UIAlertController (title : "Titre_du_message", message: zoneSaisie.text, preferredStyle: .actionSheet)
            controler.addAction(action1)
            controler.addAction(action3)
            self.present(controler,animated: true, completion: nil)
        }
    }
    
    @IBAction func boutonCacher(_ sender : UIButton){
        if sender.currentTitle == "Cacher !" {
            textTitre.isHidden = true
            zoneSaisie.isHidden = true
            segmentedControl.isHidden = true
            boutonLancer.isHidden = true
            sender.setTitle("Montrer", for: .normal)
        }else{
            textTitre.isHidden = false
            zoneSaisie.isHidden = false
            segmentedControl.isHidden = false
            boutonLancer.isHidden = false
            sender.setTitle("Cacher !", for: .normal)
        }
    }
}

