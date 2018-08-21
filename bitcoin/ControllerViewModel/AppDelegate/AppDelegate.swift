//
//  AppDelegate.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureAppearance()
        UIApplication.shared.statusBarStyle = .lightContent
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        return true
    }
    
    
    func configureAppearance() {
        let appearance = UINavigationBar.appearance()
        appearance.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        appearance.shadowImage = UIImage()
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.tintColor = .white
        appearance.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor.white]
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setBorderColor(.white)
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.3019607843, green: 0.6352941176, blue: 0.5333333333, alpha: 1))
        SVProgressHUD.setForegroundColor(.white)

    }

}

