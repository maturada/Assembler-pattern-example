//
//  Assembler.swift
//  Assembler
//
//  Created by David Matura on 23/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import Foundation

protocol Assembler: class {

    func configure()

    func resolve<T>() -> T

    func resolve<T>(_ :T.Type) -> T
}

protocol AssemblerRegistry: class {

    func register<T>(scope: Scope, factory: @escaping ((AssemblerResolver) -> T))
}

protocol AssemblerResolver: class {

    func resolve<T>() -> T

    func resolve<T>(_ :T.Type) -> T
}

protocol ComponentAssembler: class {

    func register(to registry: AssemblerRegistry)
}
