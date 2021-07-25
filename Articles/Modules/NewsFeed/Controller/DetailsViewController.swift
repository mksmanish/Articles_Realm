//
//  DetailsView.swift
//  ObserverNotification
//
//  Created by manish on 23/07/21.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var btnFavouriteOutlet: UIButton!
    @IBOutlet weak var btnLikedOutlet: UIButton!
    @IBOutlet weak var btnSavedOutlet: UIButton!
    var itemobj:Item?
    var itemSaved:MainModelClass?
    var checked = false
    var directNavigatefeed:Bool?
    var directNavigateSave:Bool?
    var answer : [String:Bool] = [:]
    var arrSavedData = [MainResponse]()
    var realm: Realm?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupUI()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        self.getDatafromrealm()
        
        
    }
    
    func setupUI() {
        
        realm = try! Realm()
        
        imgPicture.contentMode = .scaleToFill
        imgPicture.adjustsImageSizeForAccessibilityContentSizeCategory = true
        if directNavigatefeed == true {
            let stringUrl = itemobj?.thumbnail.replacingOccurrences(of: "&amp;", with: "&") ?? ""
            let url = URL(string:stringUrl)
            imgPicture.kf.setImage(with: url)
            lbldescription.text = itemobj?.content
            
        }
        if directNavigateSave == true{
            
            let stringUrl = itemSaved?.thumbnail?.replacingOccurrences(of: "&amp;", with: "&") ?? ""
            let url = URL(string:stringUrl)
            imgPicture.kf.setImage(with: url)
            lbldescription.text = itemSaved?.content
            
            
        }
  
    }
    func changeImageOnclick(notclicked:UIImage,clicked:UIImage,sender:UIButton) {
        if checked {
            sender.setImage(notclicked, for: .normal)
            checked = false
        } else {
            sender.setImage(clicked, for: .normal)
            checked = true
        }
    }
    func saveDataInRealm() {
        
        let mainModel = MainModelClass()
        mainModel.author = itemobj?.author
        mainModel.content = itemobj?.content
        mainModel.link = itemobj?.link
        mainModel.itemDescription = itemobj?.itemDescription
        mainModel.title = itemobj?.title
        mainModel.thumbnail = itemobj?.thumbnail
        mainModel.pubDate = itemobj?.pubDate
        
        
        // saving the data in realm database
        realm?.beginWrite()
        realm?.add(mainModel)
        try! realm?.commitWrite()
    }
    func getDatafromrealm() {
        realm?.beginWrite()
        let data = realm?.objects(MainModelClass.self)
        let jsonData = try! JSONEncoder().encode(data)
        let decoder = JSONDecoder()
        do{
            
            let result = try decoder.decode([MainResponse].self, from: jsonData)
            for i in 0..<result.count {
                arrSavedData.append(result[i])
            }
            
        }
        catch let error as NSError{
            // error.description
            print(error.description)
        }
        
        try! realm?.commitWrite()
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        //   NotificationCenter.default.post(name: notification.like, object: nil, userInfo: answer)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLiked(_ sender: UIButton) {
        
        changeImageOnclick(notclicked:  UIImage(systemName:"heart")!, clicked: UIImage(systemName:"heart.fill")!, sender: sender)
        
        
    }
    
    @IBAction func btnFavourites(_ sender: UIButton) {
        changeImageOnclick(notclicked:  UIImage(systemName:"paperplane.circle")!, clicked: UIImage(systemName:"paperplane.circle.fill")!, sender: sender)
        answer["answer"] = true
        
        
    }
    
    @IBAction func btnSaved(_ sender: UIButton) {
        changeImageOnclick(notclicked:  UIImage(systemName:"square.and.arrow.up")!, clicked: UIImage(systemName:"square.and.arrow.up.fill")!, sender: sender)
        
        let alert = UIAlertController(title: "Save", message:Message.constantmessage.DoYouWant , preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.saveDataInRealm()
            let alert = UIAlertController(title: "Saved Data", message:Message.constantmessage.DataSaved, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
