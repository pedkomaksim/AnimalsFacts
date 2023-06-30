//
//  ShareSheet.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 30.06.2023.
//

import Foundation
import UIKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
    
}
