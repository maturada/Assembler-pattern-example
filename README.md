# Assebler-pattern-example
This is example of using assembler pattern in practice.

```
// One assembler that exists for an app.
// Injecting set of assembler components
// that are being register on configure().
protocol Assembler: class {

    func configure()

    func resolve<T>() -> T

    func resolve<T>(_ :T.Type) -> T
}

// Registery is created on Assembler.configure() and is passed to AssemblerComponent through register(to: ..).
protocol AssemblerRegistry: class {

    func register<T>(scope: Scope, factory: @escaping ((AssemblerResolver) -> T))
}

// Resolve dependecies for component - wrapper for container to avoid exposing the entire interface.
protocol AssemblerResolver: class {

    func resolve<T>() -> T

    func resolve<T>(_ :T.Type) -> T
}

// One for each component. -> Factory
protocol ComponentAssembler: class {

    func register(to registry: AssemblerRegistry)
}
```
