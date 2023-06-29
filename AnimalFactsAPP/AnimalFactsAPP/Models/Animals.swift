//
//  Animals.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 28.06.2023.
//

import Foundation

struct Animal: Decodable, Equatable {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: Status?
    let content: [AnimalFact]?

    enum Status: String, Decodable {
        case paid
        case free
        case comingSoon
    }
    
    init(
        title: String,
        description: String,
        image: String,
        order: Int,
        status: Status? = .comingSoon,
        content: [AnimalFact]?
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.order = order
        self.status = status
        self.content = content
    }
}

struct AnimalFact: Decodable, Equatable {
    let fact: String
    let image: String
}

extension AnimalFact: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(fact)
        hasher.combine(image)
    }

    static func ==(lhs: AnimalFact, rhs: AnimalFact) -> Bool {
        return lhs.fact == rhs.fact && lhs.image == rhs.image
    }
}

extension Animal {
    static var sample: [Animal] {
    [
        Animal(
            title: "Dogs 🐕",
            description: "Different facts about dogs",
            image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
            order: 1,
            status: .paid,
            content: [
                .init(
                    fact: "During the Renaissance, detailed portraits of the dog as a symbol of fidelity and loyalty appeared in mythological, allegorical, and religious art throughout Europe, including works by Leonardo da Vinci, Diego Velázquez, Jan van Eyck, and Albrecht Durer.",
                    image: "https://images.dog.ceo/breeds/basenji/n02110806_4150.jpg"
                ),
                .init(
                    fact: "The Mayans and Aztecs symbolized every tenth day with the dog, and those born under this sign were believed to have outstanding leadership skills.",
                    image: "https://images.dog.ceo/breeds/cotondetulear/100_2397.jpg"
                )
            ]
        ),
        Animal(
            title: "Cats 🐈",
            description: "Different facts about cats",
            image: "https://images6.alphacoders.com/337/337780.jpg",
            order: 2,
            status: .free,
            content: [
                .init(
                    fact: "A cat cannot see directly under its nose.",
                    image: "https://cataas.com/cat"
                ),
                .init(
                    fact: "When a cat drinks, its tongue - which has tiny barbs on it - scoops the liquid up backwards.",
                    image: "https://cataas.com/cat"
                )
            ]
        )
    ]
        
    }
}
