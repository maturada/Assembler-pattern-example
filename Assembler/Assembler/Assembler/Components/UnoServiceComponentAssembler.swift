//
//  UnoServiceComponentAssembler.swift
//  Assembler
//
//  Created by David Matura on 24/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import Foundation

final class UnoServiceComponentAssembler: ComponentAssembler {

    func register(to registry: AssemblerRegistry) {

        registry.register(scope: .weak) { _ -> Service in

            UnoService()
        }
    }
}
