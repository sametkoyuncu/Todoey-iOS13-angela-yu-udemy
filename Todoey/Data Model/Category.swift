//
//  Category.swift
//  Todoey
//
//  Created by Samet Koyuncu on 6.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<Item>()
}
