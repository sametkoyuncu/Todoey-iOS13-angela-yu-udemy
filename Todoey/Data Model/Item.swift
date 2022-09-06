//
//  Item.swift
//  Todoey
//
//  Created by Samet Koyuncu on 6.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @Persisted var title: String = ""
    @Persisted var isDone: Bool = false
    @Persisted var createdAt: Double = Date().timeIntervalSince1970
    var parentCategory = LinkingObjects.init(fromType: Category.self, property: "items")
}
