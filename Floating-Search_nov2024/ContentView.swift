//
//  ContentView.swift
//  Floating-Search_nov2024
//
//  Created by mac on 25/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 20) {
                ForEach(viewModel.filteredCars, id: \.1) { car in
                    VStack {
                        Image(car.1) // Replace with actual image assets
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 150, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Text(car.0)
                            .font(.headline)
                    }
                }
            }
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .top, spacing: 20) {
            searchbar
        }
    }
    
    var searchbar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Search", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .foregroundColor(.gray)
        .padding(12)
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 10, x: 2, y: 2)
        .padding(.horizontal)
    }
}


#Preview {
    ContentView()
}


class ViewModel: ObservableObject {
    
    init() {
        self.filteredCars = cars
    }
    
    let cars = [
        ("T", "image-1"), ("S", "image-2"), ("A", "image-3"),
        ("C", "image-4"), ("C", "image-5"), ("C", "image-6"),
        ("V", "image-7"), ("B", "image-8"), ("M", "image-9"),
        ("N", "image-10"), ("O", "image-11"), ("B", "image-12")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty {
                filteredCars = cars
            } else {
                filteredCars = cars.filter { $0.0 == searchText }
            }
        }
    }
    
    @Published var filteredCars: [(String, String)] = []
    
}
