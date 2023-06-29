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
    let categoryTitle: String
    
    @State private var isShareSheetPresented = false // Добавляем состояние для отображения share sheet
    
    var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView {
                GeometryReader { geometry in
                    ZStack {
                        Color("rouse")
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            if let fact = viewStore.currentFact {
                                AsyncImage(url: URL(string: fact.image)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200)
                                            .clipped()
                                            .padding(20.0)
                                    } else if phase.error != nil {
                                        Text(phase.error?.localizedDescription ?? "Error")
                                            .foregroundColor(.pink)
                                            .frame(width: 200, height: 200)
                                    } else {
                                        ProgressView()
                                            .frame(width: 200, height: 200)
                                    }
                                }
                                .id(fact)
                                
                                Text(fact.fact)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                            } else {
                                Text("No facts available")
                                    .font(.headline)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    viewStore.send(.previousFact)
                                }) {
                                    Image(systemName: "arrow.left")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.black)
                                }
                                .disabled(!viewStore.canGoToPreviousFact)
                                
                                Spacer()
                                
                                Button(action: {
                                    viewStore.send(.nextFact)
                                }) {
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.black)
                                }
                                .disabled(!viewStore.canGoToNextFact)
                            }
                            .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .padding()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .navigationTitle(categoryTitle)
            .navigationBarItems(trailing:
                Button(action: {
                    isShareSheetPresented = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
                .sheet(isPresented: $isShareSheetPresented) {
                    // Здесь открывается share sheet с фактом
                    if let fact = viewStore.currentFact {
                        ShareSheet(activityItems: [fact.fact])
                    }
                }
            )
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
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
        ), categoryTitle: Animal.sample[0].title)
    }
}

