//
//  RootComponentAssembler.swift
//  Assembler
//
//  Created by David Matura on 23/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import UIKit

final class RootComponentAssembler: ComponentAssembler {

    var window: UIWindow?

    func register(to registry: AssemblerRegistry) {

        registry.register(scope: .strong) { dependencies -> ViewController in

            let rootViewController = UIStoryboard(
                name: String(describing: "Main"),
                bundle: nil
                ).instantiateInitialViewController() as! ViewController

            let navigationController = UINavigationController(
                rootViewController: rootViewController
            )

            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
            self.window = window

            return rootViewController
        }
    }
}
