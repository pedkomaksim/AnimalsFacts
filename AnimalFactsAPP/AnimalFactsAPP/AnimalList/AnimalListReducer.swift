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
    // По ТСА нужно было добавить сюда Action по отображении Alerts, но у меня не хватило времени(
    
}

struct AnimalListState: Equatable {
    
    var animals: [Animal] = []
    var selectedAnimal: Animal?
    
}

let animalListReducer = AnyReducer<AnimalListState, AnimalListAction, AnimalListEnvironment> {
    state, action, environment in
    
    switch action {
    case .fetchAnimals: // Обработка действия получения списка животных
        
        return environment.apiClient.fetchAnimals
            .mapError { _ in AnimalListAction.animalsLoaded(.failure(APIClient.Failure())) as! any Error } // Преобразование ошибки загрузки списка животных в действие с результатом ошибки
            .catchToEffect() // Преобразование в эффект
            .map(AnimalListAction.animalsLoaded) // map в action с загруженным списком животных
        
    case .animalsLoaded(let result):
        switch result {
        case .success(let animals):
            state.animals = animals.sorted(by: { $0.order < $1.order }) // Сортировка списка животных в состоянии по порядку
            
        case .failure: // Обработка ошибки при загрузке списка животных
            break
        }
        
        return .none
        
    case .animalTapped(let animal):
        state.selectedAnimal = animal // Установка выбранного животного в state
        
        return .none
    }
    
}

struct AnimalListEnvironment {
    
    var apiClient: APIClient // APIClient )
    
}
