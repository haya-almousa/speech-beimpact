
//
//  SpeechRecognizer.swift
//  speech app test
//
//  Created by Wed Ahmed Alasiri on 29/05/1447 AH.
//

import Foundation
import Speech
import AVFoundation
import Combine

class SpeechRecognizer: ObservableObject {
    @Published var transcript: String = ""

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))//ar-SA
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func start() {
        transcript = ""

        // 1️⃣ طلب إذن المايك
        AVAudioApplication.requestRecordPermission { allowed in
                    if !allowed {
                        print("❌ Microphone permission denied")
                        return
                    }

            // 2️⃣ طلب إذن التعرف على الكلام
            SFSpeechRecognizer.requestAuthorization { authStatus in
                if authStatus != .authorized {
                    print("Speech recognition not authorized")
                    return
                }

                // 3️⃣ بعد السماح، يبدأ التسجيل
                DispatchQueue.main.async {
                    self.beginRecording()
                }
            }
        }
    }

    private func beginRecording() {
        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request = request else { return }

        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)

        node.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Audio Engine Error: \(error.localizedDescription)")
        }

        task = recognizer?.recognitionTask(with: request) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.transcript = result.bestTranscription.formattedString
                }
            }
        }
    }

    func stop() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
    }
}
