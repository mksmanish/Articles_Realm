//
//  SaveViewController.swift
//  ObserverNotification
//
//  Created by manish on 24/07/21.
//

import UIKit
import RealmSwift


class SaveViewController: UIViewController {
    
    var realm : Realm?
    var arrSavedData = [MainModelClass]()
    var fromSave = true
    @IBOutlet weak var tblSaveData: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        self.getDatafromrealm()
        

    }
    
    func setUp()
    {
        realm = try! Realm()
        self.tblSaveData.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier:Constants.Indentifiers.NewsitemsTableViewCell)
    }
    
    func getDatafromrealm() {
        realm?.beginWrite()
        let data = realm?.objects(MainModelClass.self)
        let jsonData = try! JSONEncoder().encode(data)
        let decoder = JSONDecoder()
        do{
            
            let result = try decoder.decode([MainModelClass].self, from: jsonData)
            for i in 0..<result.count {
                arrSavedData.append(result[i])
                
            }
            self.tblSaveData.reloadData()
        
        
        }
        catch let error as NSError{
            // error.description
            print(error.description)
        }
    
        try! realm?.commitWrite()
    }
    ///function to delete all the objects in real db
    func realmDeleteAllClassObjects() {
        do {
            let realm = try Realm()

            let objects = realm.objects(MainModelClass.self)

            try! realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            // handle error
            print("error - \(error.localizedDescription)")
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: TableView datasources and delegates
extension SaveViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    // returns the number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSavedData.count
        
    }
    
    // returns the cell to show in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tblSaveData.dequeueReusableCell(withIdentifier: Constants.Indentifiers.NewsitemsTableViewCell, for: indexPath) as! NewsitemsTableViewCell
            cell.selectionStyle = .none
            let dateVariable = DateFunctions.sharedInstance
            cell.lblTitle.text = self.arrSavedData[indexPath.row].title
            cell.imgPicture.contentMode = .scaleToFill
            cell.imgPicture.adjustsImageSizeForAccessibilityContentSizeCategory = true
        cell.lblDate.text = dateVariable.getDateFromUTC(date: self.arrSavedData[indexPath.row].pubDate ?? "")
        cell.lblTime.text = dateVariable.getTimeFromUTC(date: self.arrSavedData[indexPath.row].pubDate ?? "")
        let stringUrl = (self.arrSavedData[indexPath.row].thumbnail)?.replacingOccurrences(of: "&amp;", with: "&") ?? ""
            let url = URL(string:stringUrl)
            cell.imgPicture.kf.setImage(with: url)
            return cell
     
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailsViewController") as DetailsViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.itemSaved = self.arrSavedData[indexPath.row]
        vc.directNavigateSave = fromSave
        self.present(vc, animated: true, completion: nil)
        
    }
   
    // returns the height of the each row in tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return CGFloat(Constants.rowHeight.regularArticle)
    
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            realm?.beginWrite()
//            realm?.delete(arrSavedData[indexPath.row])
//            try! realm?.commitWrite()
//            self.tblSaveData.reloadData()
            
        }
    }
}
