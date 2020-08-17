//
//  DetailRepositoryViewModelController.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 17.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

class DetailRepositoryViewModelController {
    private var repository = RepositoryViewModel()
    private var commit = [CommitModel]()
    private var detail = DetailRepositoryViewModel()
    private var commitURL: String = ""
    
    func fetchRepository (completion: @escaping (Result<[CommitModel], Error>) -> Void) {
        HTTPManager.shared.get(urlString: commitURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do {
                    self.commit = try decoder.decode([CommitModel].self, from: dta)
                    self.fromModelToModelView()
                    completion(.success(try decoder.decode([CommitModel].self, from: dta)))
                } catch {
                }
            }
        })
    }
    
    func viewModel() -> DetailRepositoryViewModel {
        return detail
    }
    
    func setRepository(_ repo: RepositoryViewModel) -> () {
        repository = repo
    }
    
    func setCommitURL(_ url: String ) -> () {
        commitURL = url
    }
    
    
    private func fromModelToModelView(){
        detail.date = commit[0].commit.author.formatDate(commit[0].commit.author.date)
        detail.message = commit[0].commit.message
        detail.nameAuthorCommit = commit[0].commit.author.name
        detail.parents = commit[0].parents.map{$0.sha}
        detail.avatarAuthor = repository.avatarAuthor
        detail.loginAuthor = repository.loginAuthor
        detail.repositoryName = repository.repositoryName
        
    }
}
