// Recorder.swift
//
// Created by TeChris on 22.04.21.

import AVFoundation

private let session = AVCaptureSession()
private var movieFileOutput = AVCaptureMovieFileOutput()

/// Record the mac's screen.
class Recorder: NSObject, AVCaptureFileOutputRecordingDelegate {
	func record(to url: URL) {
		// Get the main display's ID.
		let displayID = CGMainDisplayID()
		
		// Create a new input.
		guard let input = AVCaptureScreenInput(displayID: displayID) else {
			// If the process of creating an input failed, return.
			print("Failed to create input.")
			return
		}
		
		// Configure the capture session.
		session.sessionPreset = (UserDefaults.standard.value(forKey: "Resolution") as? Resolution)?.captureSessionPreset ?? .hd1920x1080
		
		// Check if the session can add the new input.
		if session.canAddInput(input) {
			// Add the new input to the capture session.
			session.addInput(input)
		}
		
		// Check if the output can be added to the session.
		if session.canAddOutput(movieFileOutput) {
			// Add the output to the capture session.
			session.addOutput(movieFileOutput)
		}
		
		// Start the capture session.
		session.startRunning()
		
		// Start writing to the specified file.
		movieFileOutput.startRecording(to: url.appendingPathComponent("NewRecording.mp4"), recordingDelegate: self)
	}
	
	func stopRecording() {
		// Stop writing to the file.
		movieFileOutput.stopRecording()
		
		// Stop the session.
		session.stopRunning()
	}
	
	func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
		if let error = error {
			print("Error: \(error)")
		}
	}
}
