//
//  AppDelegate.swift
//  GeeksAssigment
//
//  Created by manish on 23/07/21.
//

import UIKit
import RealmSwift
import Siren

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var isInternetConnected = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupSiren()
        let config = Realm.Configuration(schemaVersion : 1,migrationBlock: {migration ,oldschema in if oldschema < 1{}})
        Realm.Configuration.defaultConfiguration = config
        return true
    }
    
    //setup siren for Force Update
    func setupSiren() {
        
        /// How to present an alert every time the app is foregrounded.
        /// This will block the user from using the app until they update the app.
        /// Setting `showAlertAfterCurrentVersionHasBeenReleasedForDays` to `0` IS NOT RECOMMENDED
        /// as it will cause the user to go into an endless loop to the App Store if the JSON results
        /// update faster than the App Store CDN.
        ///
        /// The `0` value is illustrated in this app as an example on how to change how quickly an alert is presented.
        
        let siren = Siren.shared
        siren.rulesManager = RulesManager(globalRules: .critical,
                                          showAlertAfterCurrentVersionHasBeenReleasedForDays: 0)
        
        siren.apiManager = APIManager(countryCode: "IN")
        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

