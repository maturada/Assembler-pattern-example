//
//  AssemblerTests.swift
//  AssemblerTests
//
//  Created by David Matura on 24/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import XCTest
@testable import Assembler

class AssemblerTests: XCTestCase {

    func testAssembler() {

        let assembler = AppAssembler(components: [
            TestServiceOneComponentAssembler(),
            TestServiceTwoComponentAssembler()
            ]
        )

        assembler.configure()

        var serviceTwo: TestServiceTwo? = assembler.resolve(TestServiceTwo.self)
        var serviceOne: TestServiceOne? = serviceTwo?.service as? TestServiceOne

        XCTAssertNotNil(serviceTwo)
        XCTAssertNotNil(serviceOne)

        serviceOne = nil
        XCTAssertNil(serviceOne)
        serviceTwo = nil
        XCTAssertNil(serviceTwo)

    }
}

// MARK: - Test classes.

class TestServiceOne: Service {

    weak var service: Service?


}

private class TestServiceOneComponentAssembler: ComponentAssembler {

    func register(to registry: AssemblerRegistry) {

        registry.register(scope: .weak) { factory -> Service in

            TestServiceOne()
        }
    }
}


class TestServiceTwo: Service {

    let service: Service

    init(service: Service) {

        self.service = service
    }
}

private class TestServiceTwoComponentAssembler: ComponentAssembler {

    func register(to registry: AssemblerRegistry) {

        registry.register(scope: .strong) { factory -> Service in

            // Tightly coupled - test references.
            let serviceOne: TestServiceOne = factory.resolve(TestServiceOne.self)
            let serviceTwo = TestServiceTwo(service: serviceOne)

            serviceOne.service = serviceTwo

            return serviceTwo
        }
    }
}
