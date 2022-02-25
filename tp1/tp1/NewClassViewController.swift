//
//  NewClassViewController.swift
//  tp1
//
//  Created by admin on 25/02/2022.
//

import UIKit

class NewClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func switchB(_ sender : UISwitch){
        if sender.isOn {
            
        }
    }
    
    @IBAction func boutonRetour(_ sender : UIBarButtonItem){
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
