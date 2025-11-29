//
//  CameraView.swift
//  OnMyWatch
//
//  Created by Facundo Kzemin on 29/11/2025.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var viewModel = CameraViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                CameraPreview(session: viewModel.session)
                    .ignoresSafeArea()

                if viewModel.permissionDenied {
                    Text("No hay permiso para usar la cámara")
                        .font(.headline)
                        .padding()
                        .background(.black.opacity(0.6))
                        .cornerRadius(10)
                }
                
                VStack {
                    Spacer()
                    
                    NavigationLink("Go to ContentView") {
                        ContentView()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .task {
                await viewModel.start()
            }
            .onDisappear {
                viewModel.stop()
            }
        }
    }
}

#Preview {
    CameraView()
}
