//
//  AnimalDetailView.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//

import SwiftUI
import ComposableArchitecture

struct AnimalDetailView: View {
    let store: Store<AnimalDetailState, AnimalDetailAction>
    
    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                AsyncImage(url: URL(string: viewStore.animal.image)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFit()
                            .frame( height: 200)
                            .clipped()
                        
                    } else if phase.error != nil {
                        
                        Text(phase.error?.localizedDescription ?? "error")
                            .foregroundColor(Color.pink)
                            .frame(width: 200, height: 200)
                    } else {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    }
                }
                
                if let fact = viewStore.currentFact {
                    VStack(alignment: .leading) {
                                Text(fact.fact)
                                    .font(.headline)
                                AsyncImage(url: URL(string: fact.image)) { phase in
                                    if let image = phase.image {
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                            .clipped()
                                    } else if phase.error != nil {
                                        Text(phase.error?.localizedDescription ?? "error")
                                            .foregroundColor(Color.pink)
                                            .frame(width: 200, height: 200)
                                    } else {
                                        ProgressView()
                                            .frame(width: 200, height: 200)
                                    }
                                }
                                .id(fact)
                            }
                } else {
                    Text("No facts available")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
                HStack {
                    Button(action: {
                        viewStore.send(.previousFact)
                    }) {
                        Image(systemName: "arrow.left")
                    }
                    .disabled(!viewStore.canGoToPreviousFact)
                    
                    Spacer()
                    
                    Button(action: {
                        viewStore.send(.nextFact)
                    }) {
                        Image(systemName: "arrow.right")
                    }
                    .disabled(!viewStore.canGoToNextFact)
                }
            }
            .padding()
        }
    }
}

struct AnimalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalDetailView(store: Store(
            initialState: AnimalDetailState(
                animal: Animal.sample[0],
                currentFactIndex: 0
            ),
            reducer: animalDetailReducer,
            environment: AnimalListEnvironment(apiClient: APIClient.live)
        ))
    }
}

