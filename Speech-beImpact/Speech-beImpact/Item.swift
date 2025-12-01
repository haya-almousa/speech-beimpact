
//  Item.swift
//  speech app test
//
//  Created by Wed Ahmed Alasiri on 29/05/1447 AH.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
