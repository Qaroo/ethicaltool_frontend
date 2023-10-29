//
//  FindCarViewController.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 25/05/2022.
//

import UIKit

class FindCarViewController: UIViewController {

    @IBOutlet weak var carnumTF: UITextField!
    @IBOutlet weak var dataTF: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func searchTapped(_ sender: Any) {
        var iz = "https://lastcar.cyberproject.repl.co/findcar/\(self.carnumTF.text!)"
        
        
        let urlz = URL(string: iz)!
        
        var request = URLRequest(url: urlz)
        request.httpMethod = "GET"
        
        

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
            print("response:\(responseString)")
            if responseString.contains("data") {
                var code = responseString.components(separatedBy: "data")[1] as! String
                
                print("code:\(code)")
                DispatchQueue.main.async {
                    self.dataTF.text = code

                }
            }
            
        }

        taskz.resume()
    }
    
    

}
