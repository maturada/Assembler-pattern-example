//
//  Service.swift
//  Assembler
//
//  Created by David Matura on 24/05/2019.
//  Copyright © 2019 David Matura. All rights reserved.
//

import Foundation

protocol Service: class {

 // Public interface.
}

class UnoService: Service {
    
    // Some implementation of the protocol.
}

class NunoService: Service {

    private let service: Service

    init(service: Service) {

        self.service = service
    }

    // Some implementation of the protocol.
}
