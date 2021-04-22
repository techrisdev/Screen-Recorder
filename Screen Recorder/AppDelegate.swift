// AppDelegate.swift
//
// Created by TeChris on 22.04.21.

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let buttonView = NSHostingView(rootView: ContentView())
		buttonView.frame = NSRect(x: 0, y: 0, width: 22, height: 22)
		statusItem.button?.addSubview(buttonView)
		statusItem.button?.action = #selector(statusItemClicked)
		statusItem.button?.sendAction(on: [.leftMouseDown, .rightMouseDown])
	}
	
	@objc func statusItemClicked() {
		// Chech if the right or left mouse button was clicked.
		guard let currentEvent = NSApp.currentEvent else { return }
		
		if currentEvent.type == .rightMouseDown {
			// The right mouse button was clicked, show the app's preferences.
			// Configure the window.
			let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 480, height: 320), styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView], backing: .buffered, defer: false)
			window.title = "Preferences"
			window.center()
			window.isReleasedWhenClosed = false
			window.contentView = NSHostingView(rootView: PreferencesView())
			window.makeKeyAndOrderFront(nil)
			
		} else if currentEvent.type == .leftMouseDown {
			// The left mouse button was clicked, start/stop the recording.
			NotificationCenter.default.post(name: .StatusItemClickedNotification, object: nil)
		}
	}
}

extension Notification.Name {
	static let StatusItemClickedNotification = Notification.Name("StatusItemClickedNotification")
}
