//
//  AppAssembler.swift
//  Assembler
//
//  Created by David Matura on 23/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import Foundation

final class AppAssembler: Assembler {

    private let components: [ComponentAssembler]
    private let container: Container

    init(components: [ComponentAssembler]) {

        self.container = Container()
        self.components = components
    }

    deinit {

        container.reset()
    }

    func configure() {

        let resolver = DefaultAssemblerResolver(container: container)
        let registry = AppAssemblerRegistry(resolver: resolver, container: container)
        components.forEach { component in
            component.register(to: registry)
        }

        container.cleanWeak()
    }

    func resolve<T>() -> T {

        return container.resolve()
    }

    func resolve<T>(_ :T.Type) -> T {

        return container.resolve(T.self)
    }
}

private class AppAssemblerRegistry: AssemblerRegistry {

    private let resolver: AssemblerResolver
    private let container: Container

    init(resolver: AssemblerResolver, container: Container) {

        self.resolver = resolver
        self.container = container
    }

    func register<T>(scope: Scope, factory: @escaping ((AssemblerResolver) -> T)) {

        container.add(
            scope: scope, factory(resolver)
        )
    }
}

private class DefaultAssemblerResolver: AssemblerResolver {

    private let container: Container

    init(container: Container) {

        self.container = container
    }

    func resolve<T>() -> T {

        return container.resolve()
    }

    func resolve<T>( _ :T.Type) -> T {

        return container.resolve(T.self)
    }
}

private class Container {

    private var strongdependencies: [Any] = []
    private var weakDependencies: [Any] = []

    func add(scope: Scope, _ dependency: Any) {

        switch scope {
        case .strong:
            strongdependencies.append(dependency)
        case .weak:
            weakDependencies.append(dependency)
        }
    }

    func cleanWeak() {

        weakDependencies = []
    }

    func resolve<T>() -> T {

        let dependencies = (self.strongdependencies + self.weakDependencies)

        return dependencies.first {
            $0 is T
            } as! T
    }

    func resolve<T>(_ :T.Type) -> T {

        let dependencies = (self.strongdependencies + self.weakDependencies)

        return dependencies.first {
            $0 is T
            } as! T
    }

    func reset() {

        strongdependencies = []
        weakDependencies = []
    }
}

// Scope of the instance.
enum Scope {

    case strong
    case weak
}
