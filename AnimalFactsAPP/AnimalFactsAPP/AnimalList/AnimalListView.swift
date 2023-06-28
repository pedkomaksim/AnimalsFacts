//
//  AnimalListView.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//

import SwiftUI
import ComposableArchitecture

struct AnimalListView: View {
    let store: Store<AnimalListState, AnimalListAction>
    
    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                List(viewStore.animals, id: \.title) { animal in
                    NavigationLink(destination: AnimalDetailView(store: Store(
                        initialState: AnimalDetailState(
                            animal: animal,
                            currentFactIndex: 0
                        ),
                        reducer: animalDetailReducer,
                        environment: AnimalListEnvironment(apiClient: APIClient.live)
                    ))) {
                        VStack(alignment: .leading) {
                            Text(animal.title)
                                .font(.headline)
                            Text(animal.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onAppear {
                    viewStore.send(.fetchAnimals)
                }
            }
            .navigationTitle("Animal Facts")
        }
    }
}

struct AnimalListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalListView(store: Store(
            initialState: AnimalListState(animals: Animal.sample),
            reducer: animalListReducer,
            environment: AnimalListEnvironment(apiClient: APIClient.live)
        ))
    }
}

