//
//  AnimalDetailReduser.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//

import Foundation
import ComposableArchitecture

enum AnimalDetailAction {
    
    case nextFact
    case previousFact
    // По ТСА нужно было добавить сюда Action по отображении ShareSheet, но у меня не хватило времени( 
    
}

struct AnimalDetailState: Equatable {
    
    let animal: Animal
    var currentFactIndex: Int = 0
    
    var currentFact: AnimalFact? {
        guard let content = animal.content, content.indices.contains(currentFactIndex) else {
            return nil
        }
        
        return content[currentFactIndex]
    }
    
    var canGoToPreviousFact: Bool {
        currentFactIndex > 0
    }
    
    var canGoToNextFact: Bool {
        guard let content = animal.content else {
            return false
        }
        
        return currentFactIndex < content.count - 1
    }
    
}

let animalDetailReducer = AnyReducer<AnimalDetailState, AnimalDetailAction, AnimalListEnvironment> { state, action, environment in
    switch action {
    case .nextFact:
        state.currentFactIndex += 1
        
        return .none
        
    case .previousFact:
        state.currentFactIndex -= 1
        
        return .none
    }
    
}
