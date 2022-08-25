//
//  File.swift
//  
//
//  Created by Nikita Mikheev on 23.08.2022.
//

import Foundation

public protocol LogProviding {
    func makeSections() -> [LogSection]
}
