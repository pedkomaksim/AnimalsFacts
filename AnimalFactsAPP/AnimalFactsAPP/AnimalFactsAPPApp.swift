//
//  AnimalFactsAPPApp.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 26.06.2023.
//

import ComposableArchitecture
import SwiftUI

@main
struct AnimalsFactsApp: App {
    let store: Store<AnimalListState, AnimalListAction>
    let viewStore: ViewStore<AnimalListState, AnimalListAction>
    
    init() {
        let apiClient = APIClient.live
        let initialState = AnimalListState()
        let environment = AnimalListEnvironment(apiClient: apiClient)
        
        store = Store(initialState: initialState, reducer: animalListReducer, environment: environment)
        viewStore = ViewStore(store)
    }
    
    var body: some Scene {
        WindowGroup {
            AnimalListView(store: store)
        }
    }
}

