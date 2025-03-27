//
//  FoodScanningViewController.swift
//  Nutrak
//
//  Created by Kandhal AB on 26/03/25.
//


import UIKit
import AVFoundation

class FoodScanningViewController: UIViewController {
    
    // MARK: - IBOutlet Properties (Connect these in Storyboard)
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var scanGuideView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupOverlay()
    }
    
    // MARK: - Camera Setup
    private func setupCamera() {
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No camera found")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            let output = AVCapturePhotoOutput()
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = previewView.bounds
            previewView.layer.addSublayer(previewLayer)
            
            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    // MARK: - Overlay Setup
    private func setupOverlay() {
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        let scanFrame = CGRect(x: overlayView.frame.midX - 100, y: overlayView.frame.midY - 100, width: 200, height: 200)
        
        let maskPath = UIBezierPath(rect: overlayView.bounds)
        let scanPath = UIBezierPath(roundedRect: scanFrame, cornerRadius: 10)
        maskPath.append(scanPath)
        maskPath.usesEvenOddFillRule = true
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.fillRule = .evenOdd
        overlayView.layer.mask = maskLayer
        
        let scanBorder = CAShapeLayer()
        scanBorder.path = scanPath.cgPath
        scanBorder.strokeColor = UIColor.systemBlue.cgColor
        scanBorder.fillColor = UIColor.clear.cgColor
        scanBorder.lineWidth = 2
        
        overlayView.layer.addSublayer(scanBorder)
    }
        
    // MARK: - Capture Photo
    @IBAction func capturePhoto(_ sender: UIButton) {
        guard let output = captureSession.outputs.first as? AVCapturePhotoOutput else { return }
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    // MARK: - Close Preview
    @IBAction func closePreview(_ sender: UIButton) {
        captureButton.isHidden = false
        overlayView.isHidden = false
        captureSession.startRunning()
    }
    
    // MARK: - Back navigation
    @IBAction func actionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - add photo from gallary
    @IBAction func addFromGallary(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }

}
extension FoodScanningViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            let progressVC = self.storyboard?.instantiateViewController(identifier: "ProgressViewController") as! ProgressViewController
            self.navigationController?.pushViewController(progressVC, animated: true)
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


// MARK: - AVCapturePhotoCaptureDelegate
extension FoodScanningViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else { return }
        
        captureSession.stopRunning()
        captureButton.isHidden = true
        overlayView.isHidden = true
    }
}
