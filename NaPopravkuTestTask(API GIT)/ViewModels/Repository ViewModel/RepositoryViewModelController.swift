//
//  RepositoryViewModelController.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 16.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

class RepositoryViewModelController {
    private var repositories: [RepositoryViewModel] = []
    private var repositoryModel = [RepositoryModel]()
    
    func viewModel(at index: Int) -> RepositoryViewModel {
        return repositories[index]
    }
    
    func repositoriesCount() -> Int {
        return repositories.count
    }
    
    func fetchRepository (completion: @escaping (Result<[RepositoryModel], Error>) -> Void) {
        HTTPManager.shared.get(urlString: baseUrl + repositoriesExtensionURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                let decoder = JSONDecoder()
                do {
                    self.repositoryModel = try decoder.decode([RepositoryModel].self, from: dta)
                     self.fromModelToModelView()
                    completion(.success(try decoder.decode([RepositoryModel].self, from: dta)))
                } catch {
                }
            }
        })
    }
    
   private func fromModelToModelView(){
        for i in 0...repositoryModel.count - 1 {
            let rep = RepositoryViewModel(loginAuthor: repositoryModel[i].author.login,
                                          avatarAuthor: HTTPManager.shared.downloadImage(from: repositoryModel[i].author.avatarURL),
                                          repositoryName: repositoryModel[i].name,
                                          commitsURL: repositoryModel[i].fixCommitsUrl(repositoryModel[i].commitsURL))
            repositories.append(rep)
        }
    }
}

