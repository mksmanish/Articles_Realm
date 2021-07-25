//
//  FeedsController.swift
//  GeeksAssigment
//
//  Created by manish on 22/07/21.
//

import UIKit
import Foundation
import Kingfisher
struct notification {
    static let like = NSNotification.Name("like")
}

class FeedsController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet weak var tblViewfeeds: UITableView!
    var arrayNewsItems = [Item]()
    var fromFeed = true
   
    @IBOutlet weak var lblTitle: UILabel!
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
        self.callDataFromApi()
        self.setupNotification()
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUser), name: notification.like, object: nil)
        
    }
    @objc func handleUser(_ notification: Notification) {
        
        if let noti = notification.userInfo as NSDictionary? {
            if let answer = noti["answer"] as? Bool {
                

            }
        }
      
    }
    
    
    // function to setUp the UI
    func setUp() {
        
        self.tblViewfeeds.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier:Constants.Indentifiers.NewsitemsTableViewCell)
        
    }
    
    // MARK: General Methods
    
    // function call to get the data
    func callDataFromApi ()
    {
        self.startAnimating()
        let session = URLSession.shared
        let serviceUrl = URL(string:Constants.Urls.ServiceUrl)
        session.dataTask(with: serviceUrl!) { (responseData, responseCode, error) in
            if (error == nil && responseData != nil)
            {
                //parse the response data here
                let decoder = JSONDecoder()
                DispatchQueue.main.async {
                    do {
                        self.stopAnimating()
                        let result = try decoder.decode(NewsDetails.self, from: responseData!)
                        self.arrayNewsItems = result.items
                        
                        self.tblViewfeeds.reloadData()
                    } catch let error {
                        self.stopAnimating()
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                    }
                }
                
            }
            
        }.resume()
        
    }
    
    @IBAction func btnSavedNews(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SavingStory", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SaveViewController") as SaveViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}


// MARK: TableView datasources and delegates
extension FeedsController: UITableViewDelegate,UITableViewDataSource {
    
    
    // returns the number of rows in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayNewsItems.count
        
    }
    
    // returns the cell to show in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* since the differentiation parameter for Top and regular is provided that's why they are shown on a
        alternate fashion way */
            let cell = tblViewfeeds.dequeueReusableCell(withIdentifier: Constants.Indentifiers.NewsitemsTableViewCell, for: indexPath) as! NewsitemsTableViewCell
            cell.selectionStyle = .none
            let dateVariable = DateFunctions.sharedInstance
            cell.lblTitle.text = self.arrayNewsItems[indexPath.row].title
            cell.lblDate.text = dateVariable.getDateFromUTC(date: self.arrayNewsItems[indexPath.row].pubDate)
            cell.lblTime.text = dateVariable.getTimeFromUTC(date: self.arrayNewsItems[indexPath.row].pubDate)
            cell.imgPicture.contentMode = .scaleToFill
            cell.imgPicture.adjustsImageSizeForAccessibilityContentSizeCategory = true
            let stringUrl = (self.arrayNewsItems[indexPath.row].thumbnail).replacingOccurrences(of: "&amp;", with: "&")
            let url = URL(string:stringUrl)
            cell.imgPicture.kf.setImage(with: url)
            return cell
     
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailsViewController") as DetailsViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.itemobj = self.arrayNewsItems[indexPath.row]
        vc.directNavigatefeed = fromFeed
        self.present(vc, animated: true, completion: nil)
        
    }

    
   
    // returns the height of the each row in tableview
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return CGFloat(Constants.rowHeight.regularArticle)
    
    }
}


