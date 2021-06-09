//
//  SplashViewController.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import UIKit
import Firebase
import FirebaseRemoteConfig
import SnapKit

class SplashViewController: UIViewController {
    
    var remoteConfig = RemoteConfig.remoteConfig()
    var welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .lightGray
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.left.right.equalToSuperview().inset(10.0)
        }
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        if NetworkChecker.shared.isConnected == false {
            welcomeLabel.attributedText = NSAttributedString(string: "Internet connection not found. You can't use the app.", attributes: [.foregroundColor: UIColor.red, .font: UIFont(name: Constants.AmericanTypewriterBold, size: 24.0)!])
            return
        }
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        fetchConfig()
        
    }
    
    func fetchConfig() {
        remoteConfig.fetch { (status, error) in
            if status == .success {
                self.remoteConfig.activate { (changed, error) in
                    
                }
            } else if status == .failure {
                self.show(error: error!)
            }
            guard let message = self.remoteConfig[Constants.remoteConfigSplashKey].stringValue else { return }
            self.welcomeLabel.attributedText = NSAttributedString(string: message, attributes: [.foregroundColor: UIColor.systemYellow, .font: UIFont(name: Constants.Chalkduster, size: 48.0)!])
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                SceneDelegate.shared?.window?.rootViewController = MainViewController()
            }
        }
    }
    
    @objc func connectedToInternet() {
        
    }
}
