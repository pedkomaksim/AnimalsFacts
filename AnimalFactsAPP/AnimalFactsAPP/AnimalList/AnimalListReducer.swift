//
//  AnimalListReducer.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//

import Foundation
import ComposableArchitecture

enum AnimalListAction {
    case fetchAnimals
    case animalsLoaded(Result<[Animal], Error>)
    case animalTapped(Animal)
}

struct AnimalListState: Equatable {
    var animals: [Animal] = []
    var selectedAnimal: Animal?
}

let animalListReducer = AnyReducer<AnimalListState, AnimalListAction, AnimalListEnvironment> { state, action, environment in
    switch action {
    case .fetchAnimals:
        return environment.apiClient.fetchAnimals
            .mapError { _ in AnimalListAction.animalsLoaded(.failure(APIClient.Failure())) as! any Error }
            .catchToEffect()
            .map(AnimalListAction.animalsLoaded)
        
    case .animalsLoaded(let result):
        switch result {
        case .success(let animals):
            state.animals = animals.sorted(by: { $0.order < $1.order })
        case .failure:
            // Handle error state if needed
            break
        }
        return .none
        
    case .animalTapped(let animal):
        state.selectedAnimal = animal
        return .none
    }
}

struct AnimalListEnvironment {
    var apiClient: APIClient
}
