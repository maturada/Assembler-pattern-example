# Assembler-pattern-example
This is example of using assembler pattern in practice.

## Register component:

```
final class SomeComponent: ComponentAssembler {

    func register(to registry: AssemblerRegistry) {
    
        registry.register(score: .strong) { factory in -> ServiceProtocol {
        
            DefaultServiceImplementation(
                dep1: factory.resolve(),
                 dep2Protocol: factory.resolve(ExpectedDefaultImplementionOfProtocol.self))
        }
    }
}
```
### Resolve:
- resolve() return a first `object of a type` that is expected in order to instatiate that class/object.
- resolve() return a first `specific object` form the container of a type that is expected in order to instatiate that class/object.

## *Interface:*
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
### Scope
```
enum Scope {

    case strong
    case weak
}
```

- registry with weak scope after finishing configuration releasing reference from the conitaner.
- registy with strong scope keep reference in the container on configuration.
