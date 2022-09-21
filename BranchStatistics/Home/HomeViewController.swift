//
//  ViewController.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import UIKit
import FirebaseStorage
import ProgressHUD
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var graficsButton: UIButton!
    @IBOutlet weak var selfieButton: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var selfieImage: UIImageView!
    @IBOutlet weak var sendDataButton: UIButton!
    let storage = Storage.storage().reference()
    var selfieData: Data?
    var reference: DatabaseReference!
    var backgroundViewColor: UIColor = .backgroundStatistics
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        nameTF.delegate = self
        self.reference = Database.database().reference()
        dataBaseObserver()
        setColorDatabaseRealTime()
        setInitialSetup()
    }
    
    private func setColorDatabaseRealTime() {
        
        let dataBaseBool = UserDefaults.standard.bool(forKey: "rtdb")
        
        if !dataBaseBool{
            UserDefaults.standard.setValue(true, forKey: "rtdb")
            print("RTDB seted")
            self.reference.child("Colors").setValue(".red")
        }
    }
    
    private func dataBaseObserver() {
        self.reference.child("Colors").observe(.value) { (snapShot) in
            if let snapShot = snapShot.children.allObjects as? [DataSnapshot] {
                for snapS in snapShot {
                    if let color = snapS.value as? String {
                        print("New Background Color: \(color)")
                    }
                }
            }
        }
    }
    
    private func setInitialImage() {
        guard let urlString = UserDefaults.standard.string(forKey: "url"),
        let url = URL(string: urlString) else { return }
        ProgressHUD.show()
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            ProgressHUD.dismiss()
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.selfieImage.image = image
            }
        }
        task.resume()
    }

    private func setInitialSetup() {
        self.view.backgroundColor = self.backgroundViewColor
        selfieImage.backgroundColor = UIColor.secondarySystemFill
        selfieImage.layer.cornerRadius = selfieImage.frame.height / 2
        nameTF.placeholder = "Ingresa tu nombre"
        selfieButton.setTitle("Capturar selfie", for: .normal)
        graficsButton.setTitle("Ver estadisticas", for: .normal)
        sendDataButton.setTitle("Enviar datos", for: .normal)
        setInitialImage()
    }
    
    @IBAction func selfieAction(_ sender: Any) {
        let alert = UIAlertController(title: "Alert", message: "Procederemos a tomarte una selfie", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.imagePick()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func imagePick() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func statisticsAction(_ sender: Any) {
        let vc = StatisticsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sendDataAction(_ sender: Any) {
        if let selfieData = selfieData, nameTF.text!.count > 0 {
            ProgressHUD.show()
            storage.child("images/\(nameTF.text!).png").putData(selfieData, metadata: nil) { _, error in
                guard error == nil else {return}
                self.storage.child("images/\(self.nameTF.text!).png").downloadURL { url, error in
                    ProgressHUD.dismiss()
                    guard let url = url, error == nil else { return }
                    let urlString = url.absoluteString
                    print("Download selfie url from Firebase storage:", urlString)
                    UserDefaults.standard.set(urlString, forKey: "url")
                    
                    let alert = UIAlertController(title: "Listo!", message: "Los datos fueron enviados.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Alert", message: "Por favor ingresa tu nombre y adjunta tu foto", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        selfieImage.image = image
        
        guard let imageData = image.pngData() else { return }
        self.selfieData = imageData
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                return false
            }
        }
        catch {
            print("ERROR")
        }
        return true
    }
}
