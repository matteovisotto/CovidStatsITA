//
//  MainViewController.swift
//  CovidStatsITA
//
//  Created by Matteo Visotto on 23/08/2020.
//  Copyright © 2020 Matteo Visotto. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let italiaViewController = UINavigationController(rootViewController: ItaliaViewController())
        let regioniViewController = UINavigationController(rootViewController: RegioniViewController())
        let impostazioniViewController = UINavigationController(rootViewController: ImpostazioniViewController())
        
        if #available(iOS 11.0, *) {
            italiaViewController.navigationBar.prefersLargeTitles = true
            regioniViewController.navigationBar.prefersLargeTitles = true
            impostazioniViewController.navigationBar.prefersLargeTitles = true
        }
        
        italiaViewController.title = "Italia"
        italiaViewController.tabBarItem.image = UIImage(named: "italia")!
       
        regioniViewController.title = "Regioni"
        regioniViewController.tabBarItem.image = UIImage(named: "regioni")!
        
        impostazioniViewController.title = "Impostazioni"
        impostazioniViewController.tabBarItem.image = UIImage(named: "impostazioni")!
        
        self.viewControllers = [italiaViewController, regioniViewController, impostazioniViewController]
        
    }
    

}
