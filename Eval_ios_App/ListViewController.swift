//
//  ListViewController.swift
//  Eval_ios_App
//
//  Created by Clement  on 19/03/2019.
//  Copyright © 2019 Clement larmignat. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PizzaService.shared.getAllPizza()
        // Do any additional setup after loading the view.
    }
    // Ajouter les données dans la table view avant que la vue arrive à l'écrant
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

}

extension ListViewController: UITableViewDataSource {
    // retourne le nombre de cellule total
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PizzaService.shared.pizzas.count
    }
    // retourne une cellule à un index donné
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaCell", for: indexPath)
        let pizza = PizzaService.shared.pizzas[indexPath.row]
        cell.textLabel?.text = pizza.name
        // forme le tableau de string en string
        var ingredientsStringFormated = ""
        for ingredient in pizza.ingredients {
            ingredientsStringFormated = "\(ingredient) " + ingredientsStringFormated
        }
        cell.detailTextLabel?.text = ingredientsStringFormated
        return cell
    }
    // ne retourne q'une seule section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
