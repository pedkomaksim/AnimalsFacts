//
//  APIClient.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 28.06.2023.
//

import Foundation
import ComposableArchitecture

struct APIClient {
    var fetchAnimals: Effect<[Animal], Error>
    
    struct Failure: Error, Equatable {}
}

extension APIClient {
    static let live = Self(
        fetchAnimals: {
            URLSession.shared.dataTaskPublisher(for: URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")!)
                .map(\.data)
                .decode(type: [Animal].self, decoder: JSONDecoder())
                .mapError { _ in Failure() }
                .eraseToEffect()
        }()
    )
}
