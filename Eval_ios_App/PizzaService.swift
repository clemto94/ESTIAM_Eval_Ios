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
    private static let urlBack = URL(string: "http://localhost:8080/pizzas")!
    private init() {}
    
    private(set) var pizzas: [Pizza] = [
        Pizza(name: "margarita", ingredients: ["tomate", "mozza", "chèvre"]),
        Pizza(name: "3 fromages", ingredients: ["mozza", "chèvre", "champignons"])
    ]
    func getAllPizza() {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: PizzaService.urlBack) { (data, response, error) in
            if let data = data, error == nil {
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let responseJSON = try? JSONDecoder().decode([String: Array<Pizza>].self, from: data),
                        let pizzasRespons = responseJSON["allPizza"]{
                        self.pizzas = pizzasRespons
                        print(pizzasRespons)
                    }
                        // let author = responseJSON["quoteAuthor"] {
                        // getImage() // Une fois la citation reçue, on va chercher l'image
                    //}
                }
            }
        }
        task.resume()
    }
}
