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
        let initialState = AnimalListState() // Создание начального состояния для списка животных
        let environment = AnimalListEnvironment(apiClient: apiClient) // Создание окружения (environment) для списка животных с использованием API-клиента
        
        store = Store(initialState: initialState, reducer: animalListReducer, environment: environment) // Создание хранилища (store) с начальным состоянием, редьюсером (reducer) и окружением
        viewStore = ViewStore(store) // Создание представления (view) для хранилища (store)
    }
    
    var body: some Scene {
        WindowGroup {
            AnimalListView(store: store) // Отображение представления списка животных
        }
    }
    
}
