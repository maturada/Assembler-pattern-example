//
//  NunoServiceComponentAssembler.swift
//  Assembler
//
//  Created by David Matura on 24/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import Foundation

final class NunoServiceComponentAssembler: ComponentAssembler {

    func register(to registry: AssemblerRegistry) {

        registry.register(scope: .strong) { (dependencies) -> Service in

            NunoService(service: dependencies.resolve(UnoService.self))
        }
    }
}
