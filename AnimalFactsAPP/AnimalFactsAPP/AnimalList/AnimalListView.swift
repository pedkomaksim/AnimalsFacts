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
    @State private var isDetailViewActive = false
    @State private var detailAnimal: Animal = Animal(title: "", description: "", image: "", order: 2, status: .comingSoon, content: [])
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                WithViewStore(store) { viewStore in
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(viewStore.animals, id: \.id) { animal in
                                NavigationLink(destination: AnimalDetailView(store: Store(
                                    initialState: AnimalDetailState(
                                        animal: detailAnimal,
                                        currentFactIndex: 0
                                    ),
                                    reducer: animalDetailReducer,
                                    environment: AnimalListEnvironment(apiClient: APIClient.live)
                                ), categoryTitle: detailAnimal.title), isActive: Binding(
                                    get: { isDetailViewActive },
                                    set: { isDetailViewActive = $0 }
                                )) {
                                    AnimalRowView(animal: animal) { selectedAnimal in
                                        viewStore.send(.animalTapped(selectedAnimal))
                                        self.detailAnimal = selectedAnimal
                                        isDetailViewActive = true
                                    }
                                }
                            }
                        }
                        .padding(.top, 16)
                        .padding(.horizontal)
                        .frame(width: geometry.size.width)
                    }
                    .background(Color("rouse"))
                    .navigationTitle("Animal Facts")
                    .onAppear {
                        viewStore.send(.fetchAnimals)
                    }
                }
            }
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

