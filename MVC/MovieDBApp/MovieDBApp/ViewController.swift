//
//  ViewController.swift
//  MovieDBApp
//
//  Created by Aleksei Danilov on 25.05.2020.
//  Copyright © 2020 DanilovDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    
    private var genreList = GenreList()
    
    private let api_key = ""
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Genre List"
        
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(api_key)&language=en-US")!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                do {
                    self?.genreList = try JSONDecoder().decode(GenreList.self, from: data)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
                
            }
        }
        task.resume()
        
        
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreList.genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        cell.textLabel?.text = "\(genreList.genres[indexPath.row].id)"
        cell.detailTextLabel?.text = genreList.genres[indexPath.row].name
        return cell
    }
}

