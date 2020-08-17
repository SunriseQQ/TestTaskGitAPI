//
//  ViewController.swift
//  naPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 15.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let repositoriesViewModelController = RepositoryViewModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        settingNavigationBar()
        
        repositoriesViewModelController.fetchRepository{ [weak self] repositories in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentificator,
            let detailVC = segue.destination as? DetailRepositoryViewController,
            let repositoryIndex = tableView.indexPathForSelectedRow?.row{
            detailVC.detailRepositoryViewModelController.setCommitURL(repositoriesViewModelController.viewModel(at: repositoryIndex).commitsURL)
            detailVC.detailRepositoryViewModelController.setRepository(repositoriesViewModelController.viewModel(at: repositoryIndex))
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func settingNavigationBar() {
        navigationController?.navigationBar.topItem?.title = "List"
    }
}


extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesViewModelController.repositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repositoriesCell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell") as? RepositoryTableViewCell else {return UITableViewCell()}
        
        
        repositoriesCell.cellModel = repositoriesViewModelController.viewModel(at: indexPath.row)
        
        return repositoriesCell
    }
}

extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}






