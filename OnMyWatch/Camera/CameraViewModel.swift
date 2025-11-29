//
//  CameraViewModel.swift
//  OnMyWatch
//
//  Created by Facundo Kzemin on 29/11/2025.
//

import AVFoundation

final class CameraViewModel: NSObject, ObservableObject {
    let session = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "camera.session.queue")

    @Published var permissionDenied = false
    private var isConfigured = false

    override init() {
        super.init()
    }

    func start() async {
        await checkPermissions()
    }

    func stop() {
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            
            if self.session.isRunning {
                self.session.stopRunning()
            }
            
            // Limpieza completa de inputs/outputs
            self.session.inputs.forEach { self.session.removeInput($0) }
            self.session.outputs.forEach { self.session.removeOutput($0) }
            
            self.isConfigured = false
        }
    }

    private func checkPermissions() async {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            await configureSession()
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            await MainActor.run {
                if granted {
                    Task {
                        await self.configureSession()
                    }
                } else {
                    self.permissionDenied = true
                }
            }
        default:
            await MainActor.run {
                self.permissionDenied = true
            }
        }
    }

    private func configureSession() async {
        // Evitar configurar múltiples veces
        guard !isConfigured else { return }
        
        await withCheckedContinuation { continuation in
            sessionQueue.async { [weak self] in
                guard let self = self else {
                    continuation.resume()
                    return
                }
                
                guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                           for: .video,
                                                           position: .back),
                      let input = try? AVCaptureDeviceInput(device: device)
                else {
                    continuation.resume()
                    return
                }

                self.session.beginConfiguration()

                if self.session.canAddInput(input) {
                    self.session.addInput(input)
                }

                self.session.commitConfiguration()
                self.isConfigured = true
                self.session.startRunning()
                
                continuation.resume()
            }
        }
    }
}
