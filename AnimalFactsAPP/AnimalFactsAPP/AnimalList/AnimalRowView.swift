//
//  AnimalRowView.swift
//  AnimalFactsAPP
//
//  Created by Максим Педько on 29.06.2023.
//
import SwiftUI

struct AnimalRowView: View {
    
    var animal: Animal
    @State private var showAlert = false
    var onAnimalTapped: (Animal) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: animal.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 121, height: 90)
                } placeholder: {
                    Color.white
                }
                .frame(width: 121, height: 90)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(animal.title)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(animal.description)
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    if animal.status == .paid {
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.blue)
                            Text("Premium")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
            .background(animal.status == .comingSoon ? Color.gray.opacity(0.5) : Color.white)
            .cornerRadius(8)
            .onTapGesture {
                if animal.status == .paid || animal.status == .comingSoon {
                    showAlert = true
                } else {
                    onAnimalTapped(animal)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            if animal.status == .paid {
                return Alert(
                    title: Text("Watch Ad to continue"),
                    primaryButton: .default(Text("Show Ad")) {
                        onAnimalTapped(animal)
                        
                    },
                    secondaryButton: .cancel()
                )
            } else {
                return Alert(
                    title: Text("Appropriate Title"),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
}
