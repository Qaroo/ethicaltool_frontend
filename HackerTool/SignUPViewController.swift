//
//  SignUPViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 25/01/2022.
//

import UIKit
import FirebaseAuth
class SignUPViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var panelTF: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var teacherTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.signUpButton.layer.cornerRadius = 10
        self.signUpButton.layer.borderWidth = 1
        self.signUpButton.layer.borderColor = UIColor.red.cgColor
        self.panelTF.layer.cornerRadius = 20
    }
    

    @IBAction func signUpClicked(_ sender: Any) {
        if(teacherTF.text == "1234") {
        Auth.auth().createUser(withEmail: self.emailTF.text!, password: self.passTF.text!) { result, error in
            guard error == nil else {
                print("Account creation failed")
                let alert = UIAlertController(title: "התראה", message: "שגיאה ביצירת משתמש \(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "אישור", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            print("You have signed in")
            let alert = UIAlertController(title: "התראה", message: "החשבון נוצר בהצלחה, אתה מחובר כעת", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "אישור", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
            
        }else {
            let alert = UIAlertController(title: "התראה", message: "סיסמאת מורה שגויה", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "אישור", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
}
