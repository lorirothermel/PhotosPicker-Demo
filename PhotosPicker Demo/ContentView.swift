//
//  ContentView.swift
//  PhotosPicker Demo
//
//  Created by Lori Rothermel on 4/7/23.
//

import SwiftUI
import PhotosUI


struct ContentView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedPhotoData: Data?
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            if let selectedPhotoData, let image = UIImage(data: selectedPhotoData) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }  // if statements
        
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Label("Select a Photo", systemImage: "photo")
        }  // PhotosPicker
        .tint(.purple)
        .controlSize(.large)
        .buttonBorderShape(.roundedRectangle(radius: 5))
        .buttonStyle(.borderedProminent)
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }  // if let data
            }  // Task
        }  // onChange
        }  // ZStack
    }  // some View
}  // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
