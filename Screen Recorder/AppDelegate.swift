// AppDelegate.swift
//
// Created by TeChris on 22.04.21.

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {
	
	var window: NSWindow!
	
	let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		let buttonView = NSHostingView(rootView: ContentView())
		buttonView.frame = NSRect(x: 0, y: 0, width: 22, height: 22)
		statusItem.button?.addSubview(buttonView)
		statusItem.button?.action = #selector(statusItemClicked)
		statusItem.button?.sendAction(on: [.leftMouseDown, .rightMouseDown])
	}
	
	@objc func statusItemClicked() {
		guard let currentEvent = NSApp.currentEvent else { return }
		
		NotificationCenter.default.post(name: .StatusItemClickedNotification, object: nil)
	}
}

extension Notification.Name {
	static let StatusItemClickedNotification = Notification.Name("StatusItemClickedNotification")
}
