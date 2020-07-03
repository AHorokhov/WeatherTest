//
//  ManagerAssembly.swift
//  WeatherTest
//
//  Created by Alexey Horokhov on 03.07.2020.
//  Copyright © 2020 Alexey Horokhov. All rights reserved.
//

import Swinject

class ManagerAssembly: Assembly {

    func assemble(container: Container) {
        container.register(Manager.self) { _ in ManagerImplementation() }
    }
}

extension Assembler {
    fileprivate static let _defaultAssembler: Assembler = {
        Container.loggingFunction = nil
        return Assembler( [ManagerAssembly()] )
    }()

    static let defaultResolver = _defaultAssembler.resolver
}
