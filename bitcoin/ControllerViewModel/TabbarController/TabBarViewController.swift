//
//  TabBarViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControllers()
        configureTabBarItems()
        // Do any additional setup after loading the view.
    }
    
    func configureControllers() {
        self.viewControllers = [DashboardViewController(),TransactionViewController(),ConverterViewController()].compactMap { UINavigationController(rootViewController: $0) }
    }
    
    func configureTabBarItems() {
        tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        guard let tabs = self.tabBar.items else { return }
        tabs[0].image = #imageLiteral(resourceName: "line-chart-2").resizeImage(20)
        tabs[1].image = #imageLiteral(resourceName: "clock").resizeImage(20)
        tabs[2].image = #imageLiteral(resourceName: "bitcoin-safe-pig").resizeImage(24)
        tabs[0].title = "Main"
        tabs[1].title = "Transactions"
        tabs[2].title = "Converter"
    }
    
}

