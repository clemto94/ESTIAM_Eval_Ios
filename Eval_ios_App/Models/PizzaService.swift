//
//  PizzaService.swift
//  Eval_ios_App
//
//  Created by Clement  on 19/03/2019.
//  Copyright © 2019 Clement larmignat. All rights reserved.
//

import Foundation

class PizzaService {
    static let shared = PizzaService()
    private init() {}
    
    private(set) var pizzas: [Pizza] = [
        Pizza(name: "margarita", ingredients: ["tomate", "mozza", "chèvre"]),
        Pizza(name: "3 fromages", ingredients: ["mozza", "chèvre", "champignons"])
    ]

}
