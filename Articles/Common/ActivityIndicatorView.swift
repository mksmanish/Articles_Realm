//
//  ActivityIndicatorView.swift
//  GeeksAssigment
//
//  Created by manish on 23/07/21.
//

import Foundation
import NVActivityIndicatorView
/// This class having the ActivityIndicator used for loading the APi till data get.
class ActivityIndicatorView : NVActivityIndicatorViewable{
    
    static var indicatorView : NVActivityIndicatorView?
    static let size = CGSize(width: 30, height: 30)
    
    static func createViewOnFrame(frame:CGRect,onView:UIView){
        indicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballClipRotateMultiple, color: .blue)
        onView.addSubview(indicatorView!)
        indicatorView?.center = onView.center
    }
    
    static func startAnimating()
    {
        indicatorView?.startAnimating()
    }
    
    static func stopAnimating(){
        indicatorView?.stopAnimating()
    }
}

extension UIViewController {
    
}

var vSpinner : UIView?

extension UIViewController {
    var activityData : ActivityData {
        get { return ActivityData(size : CGSize(width: 40, height: 40),type: .ballClipRotateMultiple, color: .blue) }
    }
    
     func startAnimating()
    {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopAnimating(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
    
}

