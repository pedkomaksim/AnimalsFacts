//
//  AnimalFactsAPPApp.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 26.06.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct AnimalFactsAPPApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
                store: Store(
                    initialState: RootDomain.State(),
                    reducer: RootDomain.live
                )
            )
        }
    }
}
