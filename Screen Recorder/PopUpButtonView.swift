// PopUpButtonView.swift
//
// Created by TeChris on 22.04.21.

import SwiftUI

struct PopUpButtonView: NSViewRepresentable {
	func makeNSView(context: Context) -> some NSView {
		let nsPopUpButton = NSPopUpButton(title: "Resolution", target: context.coordinator, action: #selector(context.coordinator.action))
		nsPopUpButton.addItems(withTitles: [Resolution.hd.string, Resolution.fullHD.string, Resolution.ultraHD.string])
		
		NotificationCenter.default.addObserver(forName: Notification.Name("PopUpButtonSelectedItemChanged"), object: nil, queue: nil) { _ in
			guard let resolutionString = nsPopUpButton.selectedItem?.title else { return }
			
			// Store the new value in User Defaults.
			UserDefaults.standard.setValue(Resolution(string: resolutionString), forKey: "Resolution")
		}
		
		return nsPopUpButton
	}
	
	func updateNSView(_ nsView: NSViewType, context: Context) {
		
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator()
	}
	
	class Coordinator {
		@objc func action() {
			NotificationCenter.default.post(name: Notification.Name("PopUpButtonSelectedItemChanged"), object: nil)
		}
	}
}
