//
//  SearchViewController.swift
//  Eval_ios_App
//
//  Created by Clement  on 19/03/2019.
//  Copyright © 2019 Clement larmignat. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultTableView: UITableView!
    var searchedIngredients = [String]()
    var searchedPizza = [Pizza]()
    var searching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedPizza.count
        } else {
            return PizzaService.shared.pizzas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell",  for: indexPath)
        if searching {
            let pizza = searchedPizza[indexPath.row]
            cell.textLabel?.text = pizza.name
            var ingredientsStringFormated = ""
            for ingredient in pizza.ingredients {
                ingredientsStringFormated = "\(ingredient) " + ingredientsStringFormated
            }
            cell.detailTextLabel?.text = ingredientsStringFormated
            // cell.textLabel?.text = searchedPizza[indexPath.row].name
        } else {
            let pizza = PizzaService.shared.pizzas[indexPath.row]
            cell.textLabel?.text = pizza.name
            var ingredientsStringFormated = ""
            for ingredient in pizza.ingredients {
                ingredientsStringFormated = "\(ingredient) " + ingredientsStringFormated
            }
            cell.detailTextLabel?.text = ingredientsStringFormated
            // cell?.textLabel?.text = countryNameArr[indexPath.row]
        }
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedPizza = []
        for pizza in PizzaService.shared.pizzas {
            //searchedIngredients = pizza.ingredients.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            searchedIngredients = pizza.ingredients.filter({(ingredient: String) -> Bool in
                if ingredient.lowercased().prefix(searchText.count) == searchText.lowercased() && searchText != "" {
                    if !searchedPizza.contains(where: {$0.name == pizza.name})
                    {
                        searchedPizza.append(pizza)
                    }
                    return true
                } else {
                    return false
                }
            })
        }
        searching = true
        resultTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedPizza = []
        searching = false
        searchBar.text = ""
        view.endEditing(false)
        resultTableView.reloadData()
    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
//    }
}
