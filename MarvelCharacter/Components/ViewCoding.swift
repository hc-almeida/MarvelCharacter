//
//  ViewCoding.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 30/04/24.
//

import Foundation

public protocol ViewCoding {

    func setupHierarchy()
    func setupConstraints()
    func setupConfigurations()
}

public extension ViewCoding {

    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupConfigurations()
    }

    func setupConfigurations() {}
}
