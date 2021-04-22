// ContentView.swift
//
// Created by TeChris on 22.04.21.

import SwiftUI

struct ContentView: View {
	@State private var isRecording = false
	private let recorder = Recorder()
	var body: some View {
		Image(systemName: !isRecording ? "record.circle" : "stop.circle.fill")
			.frame(width: 22, height: 22)
			.onReceive(NotificationCenter.default.publisher(for: .StatusItemClickedNotification)) { _ in
				// When the status item has been clicked, check if we are recording right now.
				if !isRecording {
					// If we aren't recording, start recording.
					// Let the user choose a folder where the file should be saved to.
					let openPanel = NSOpenPanel()
					
					// Configure the panel.
					openPanel.canChooseFiles = false
					openPanel.canChooseDirectories = true
					openPanel.canCreateDirectories = true
					openPanel.allowsMultipleSelection = false
					
					// Present the panel.
					if openPanel.runModal() == .OK, let url = openPanel.url {
						// Start recording to the chosen folder.
						recorder.record(to: url)
						
						// Update the recording state.
						isRecording = true
					}
				} else {
					// Stop the recording.
					recorder.stopRecording()
					
					// Update the recording state.
					isRecording = false
				}
			}
	}
}
