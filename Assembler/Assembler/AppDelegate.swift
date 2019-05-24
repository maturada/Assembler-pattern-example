//
//  AppDelegate.swift
//  Assembler
//
//  Created by David Matura on 23/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private (set)var assembler: Assembler?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.assembler = configure()
        
        return true
    }

    func configure() -> Assembler {

        let assembler = AppAssembler(
            components: [
                UnoServiceComponentAssembler(),
                NunoServiceComponentAssembler(),
                RootComponentAssembler()
            ]
        )

        assembler.configure()

        return assembler
    }
}
