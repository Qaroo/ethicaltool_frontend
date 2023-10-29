//
//  categories.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 05/09/2021.
//

import UIKit
import FirebaseAuth
class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var carForm: UIView!
    @IBOutlet weak var wifiForm: UIView!
    @IBOutlet weak var mlForm: UIView!
    @IBOutlet weak var passForm: UIView!
    @IBOutlet weak var phishingForm: UIView!
    @IBOutlet weak var switch_view: UIView!
    @IBOutlet weak var switch_button: UISwitch!
    var reading:Bool = false
    
    override func viewDidLoad() {
        
        self.wifiForm.layer.cornerRadius = 10
        self.mlForm.layer.cornerRadius = 10
        self.passForm.layer.cornerRadius = 10
        self.phishingForm.layer.cornerRadius = 10
        self.carForm.layer.cornerRadius = 10
        
        if !UserDefaults.standard.bool(forKey: "reading"){
            self.switch_button.setOn(false, animated: true)
            self.reading = false
        }else{
            self.switch_button.setOn(true, animated: true)
            self.reading = true
        }
        
        if Auth.auth().currentUser == nil {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "notsignedin", sender: self)

        }
        }
    }
    
    @IBAction func wifi_scanner_clicked(_ sender: Any) {
        print("readig: \(self.reading)")
        if !self.reading{
            self.performSegue(withIdentifier: "wifi_scanner", sender: self)
        }else {
            UserDefaults.standard.set("wifi_scanning", forKey: "mode")
            self.performSegue(withIdentifier: "reading", sender: self)
        }
    }
    
    @IBAction func mitm_clicked(_ sender: Any) {
        if !self.reading{
            self.performSegue(withIdentifier: "mitm", sender: self)
        }else {
            UserDefaults.standard.set("mitm", forKey: "mode")
            self.performSegue(withIdentifier: "reading", sender: self)
        }
    }
    
    @IBAction func bruteforce_clicked(_ sender: Any) {
        if !self.reading{
            self.performSegue(withIdentifier: "brute_force", sender: self)
        }else {
            UserDefaults.standard.set("brute_force", forKey: "mode")
            self.performSegue(withIdentifier: "reading", sender: self)
        }
    }
    
    @IBAction func phishing_clicked(_ sender: Any) {
        if !self.reading{
            self.performSegue(withIdentifier: "phishing", sender: self)
        }else {
            UserDefaults.standard.set("phishing", forKey: "mode")
            self.performSegue(withIdentifier: "reading", sender: self)
        }
    }
    
    @IBAction func car_clicked(_ sender: Any) {
        if !self.reading{
            self.performSegue(withIdentifier: "car_info", sender: self)
        }else {
            UserDefaults.standard.set("car_info", forKey: "mode")
            self.performSegue(withIdentifier: "reading", sender: self)
        }
    }
    
    
    
    @IBAction func switch_changed(_ sender: Any) {
        let mode = UserDefaults.standard.bool(forKey: "reading")
        if mode == nil {
            UserDefaults.standard.set(false, forKey: "reading")
        }else {
            UserDefaults.standard.set(!mode, forKey: "reading")
        }
        self.reading = UserDefaults.standard.bool(forKey: "reading")
    }
}

