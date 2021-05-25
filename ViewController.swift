//
//  ViewController.swift
//  Movies
//
//  Created by Mannion on 3/4/21.
//  Copyright © 2021 Mannion. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies = ["Space Jam", "Jumanji", "Benchwarmers", "Sandlot"]
    
    var rating = ["⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️", "⭐️⭐️⭐️", "⭐️⭐️⭐️⭐️"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell")
        cell?.textLabel?.text = movies[indexPath.row]
        cell?.detailTextLabel?.text = rating[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = movies[indexPath.row].lowercased()
        let urlMovie = movie.replacingOccurrences(of: " ", with: "_")
        if let url = URL(string: "https://www.rottentomatoes.com/m/\(urlMovie)") {
                print(url)
            let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            }
    }
    func addAlert() {
        let teamAlert = UIAlertController(title: "Add A Movie", message: "And A Rating 1-4", preferredStyle: .alert)
        teamAlert.addTextField { (movieTextField) in
            teamAlert.addTextField { (ratingTextField) in
                let submit = UIAlertAction(title: "Enter", style: .default) { (Action) in
                    movieTextField.placeholder = "Movie"
                    ratingTextField.placeholder = "Stars"
                    switch ratingTextField.text {
                        case "1", "One", "one":
                            ratingTextField.text = "⭐️"
                        case "2", "Two", "two":
                            ratingTextField.text = "⭐️⭐️"
                        case "3", "Three", "three":
                            ratingTextField.text = "⭐️⭐️⭐️"
                        case "4", "Four", "four":
                            ratingTextField.text = "⭐️⭐️⭐️⭐️"
                        default:
                            ratingTextField.text = ""
                    }
                    self.movies.append(movieTextField.text!)
                    self.rating.append(ratingTextField.text!)
                    self.tableView.reloadData()
                }
                teamAlert.addAction(submit)
            }
        }
        present(teamAlert, animated: true, completion: nil)
    }
    
}
