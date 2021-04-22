// Resolution.swift
//
// Created by TeChris on 22.04.21.

import AVFoundation

struct Resolution {
	static let hd = Resolution(string: "1280x720 (720p)")
	static let fullHD = Resolution(string: "1920x1080 (1080p)")
	static let ultraHD = Resolution(string: "3840x2160 (4K)")
	
	var string: String
	
	var captureSessionPreset: AVCaptureSession.Preset {
		switch string {
		case Resolution.hd.string:
			return .hd1280x720
		case Resolution.fullHD.string:
			return .hd1920x1080
		case Resolution.ultraHD.string:
			return .hd4K3840x2160
		default:
			fatalError("Unknown Resolution.")
		}
	}
}
