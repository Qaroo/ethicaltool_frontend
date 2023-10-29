//
//  PhishingLogViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 26/01/2022.
//

import UIKit
import Firebase
import FirebaseFirestore
class PhishingLogViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Firestore.firestore().collection("websites").document(Auth.auth().currentUser!.uid).getDocument { snapsho, err in
            guard err == nil else {
                self.textField.text = "Error loading log \(err?.localizedDescription)"

                print("Error loading log \(err?.localizedDescription)")
                return
            }
            self.textField.text = "\(snapsho!.data()!)"
        }
    }
    

}
