//
//  DetailRepositoryViewController.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 16.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryAuthor: UILabel!
    @IBOutlet weak var commitDate: UILabel!
    @IBOutlet weak var commitMessage: UILabel!
    @IBOutlet weak var commitAuthor: UILabel!
    @IBOutlet weak var commitParents: UILabel!
    
    let detailRepositoryViewModelController = DetailRepositoryViewModelController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailRepositoryViewModelController.fetchRepository{ [weak self] repositories in
            DispatchQueue.main.async {
                self?.settingView()
            }
        }
    }
    func settingView() {
        imageView.image = detailRepositoryViewModelController.viewModel().avatarAuthor
        repositoryName.text = detailRepositoryViewModelController.viewModel().repositoryName
        repositoryAuthor.text = ("by \(detailRepositoryViewModelController.viewModel().loginAuthor)")
        commitDate.text =  ("Updated: \(detailRepositoryViewModelController.viewModel().date)")
        commitAuthor.text = detailRepositoryViewModelController.viewModel().nameAuthorCommit
        commitMessage.text = ("Last commit: \(detailRepositoryViewModelController.viewModel().message)")
        commitParents.text = ("Parents:\n \(detailRepositoryViewModelController.viewModel().parents.joined(separator: "\n "))")
        
        commitDate.font = .systemFont(ofSize: 13)
        commitAuthor.font = .boldSystemFont(ofSize: 15)
        commitParents.font = .systemFont(ofSize: 14)
        repositoryName.font = .boldSystemFont(ofSize: 17)
        
        imageView.layer.cornerRadius = imageView.layer.frame.width / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.black.cgColor
    }
}
