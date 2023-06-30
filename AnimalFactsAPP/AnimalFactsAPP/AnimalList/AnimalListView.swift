//
//  AnimalListView.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//

///
///
// GeometryReader используется для получения информации о геометрии представления, чтобы его содержимое могло быть адаптировано к размерам экрана.
// NavigationView предоставляет навигационную структуру для представления.
// ScrollView создает прокручиваемую область, которая содержит список животных.
// VStack используется для вертикального расположения элементов внутри ScrollView.
// ForEach выполняет итерацию по списку животных и отображает каждое животное в виде AnimalRowView.
// NavigationLink представляет собой ссылку на детальное представление AnimalDetailView для каждого животного.
// AnimalRowView отображает информацию о животном в списке и обрабатывает действие при нажатии на животное.
// padding используется для добавления отступов вокруг содержимого списка животных.
// frame устанавливает размеры списка животных, основываясь на размере геометрии представления.
// background устанавливает фоновый цвет представления.
// navigationTitle устанавливает заголовок навигации для представления.
// .onAppear вызывает действие .fetchAnimals при появлении представления на экране.
///
///



import SwiftUI
import ComposableArchitecture

struct AnimalListView: View {
    
    let store: Store<AnimalListState, AnimalListAction>
    @State private var isDetailViewActive = false
    @State private var detailAnimal: Animal = Animal.emptyAnimal
    
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
                                        viewStore.send(.animalTapped(selectedAnimal)) // Отправка действия при нажатии на животное
                                        self.detailAnimal = selectedAnimal // Установка выбранного животного
                                        isDetailViewActive = true // Установка флага активности детального представления
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
                        viewStore.send(.fetchAnimals) // Отправка действия для получения списка животных
                    }
                }
            }
        }
    }
    
}

struct AnimalListView_Previews: PreviewProvider {
    
    static var previews: some View {
        AnimalListView(store: Store(
            initialState: AnimalListState(animals: Animal.sample), // Установка начального состояния списка животных
            reducer: animalListReducer, // Установка редьюсера для списка животных
            environment: AnimalListEnvironment(apiClient: APIClient.live) // Установка окружения (environment) для списка животных с использованием API-клиента
        ))
    }
    
}
