//
//  mice.swift
//  Speech-beImpact
//
//  Created by Wed Ahmed Alasiri on 09/06/1447 AH.
//

import SwiftUI
import ConfettiSwiftUI

struct HomeView: View {
    @StateObject var recognizer = SpeechRecognizer()
    let db = SQLiteManager()
    
    @State var sentences: [String]
    @State private var currentIndex = 0
    @State private var confettiCounter = 0
    @State private var isRecording = false
    
    var targetWord: String {
        sentences[currentIndex]
    }
    
    @State private var resultMessage = ""
    @State private var showNextButton = false
    
    init(sentences: [String]) {
        _sentences = State(initialValue: sentences)
    }
    
    
//    let exercises: [String: [String]] = [
//        "A": ["Apple", "Air"],
//        "B": [ "Bee", "Banana"],
//        
//        
//        "C": ["Cat", "Cake", "Car"]
//    ]
    let exercises: [String: [String]] = [
        "A": ["Up", "Arm", "Yes"],
        "B": ["Ball", "Bee", "Bag"],
        "C": ["Cat", "Cup", "Car"]
    ]
 

    var body: some View {
        ZStack {
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 50) {
                Spacer().frame(height: 150)

                Text(targetWord)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 300, height: 120)
                    .background(Color(hex: "ffffff"))
                    .cornerRadius(20)
                    .opacity(0.60)

                Button(action: {
                    toggleRecording()
                }) {
                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "f6b922").opacity(0.90))
                        )
                        .shadow(color: .black.opacity(0.25), radius: 8, y: 5)
                }

                
                
                                Text("انت قلت:")
                                Text(recognizer.transcript)
                                    .foregroundColor(.gray)
                Text(resultMessage)
                    .font(.largeTitle)

                if showNextButton {
                    Button(action: {
                        nextSentence()
                    }) {
                        Text("next")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 195, height: 42)
                            .background(Color(hex: "f6b922"))
                            .cornerRadius(25)
                    }
                }

                Spacer()
            }

            ConfettiCannon(trigger: $confettiCounter)
        }
    }
    
//    func toggleRecording() {
//        if isRecording {
//            recognizer.stop()
//            checkWord()
//            isRecording = false
//        } else {
//            recognizer.start()
//            resultMessage = ""
//            showNextButton = false
//            isRecording = true
//        }
//    }
    
//
    
    func toggleRecording() {
        if isRecording {
            recognizer.stop()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                checkWord()
            }

            isRecording = false
        } else {
            recognizer.start()
            resultMessage = ""
            showNextButton = false
            isRecording = true
        }
    }

    
//    
//    func checkWord() {
//        let spoken = recognizer.transcript.trimmingCharacters(in: .whitespaces)
//        
//        
//        if spoken.contains(targetWord) {
//            // ✔️ الإجابة صحيحة
//            resultMessage = "😁"
//            db.insert(word: targetWord, correct: true)
//
//            // يظهر زر التالي فقط إذا كانت صح
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                showNextButton = true
//            }
//
//        } else {
//            // ❌ إجابة خاطئة
//            resultMessage = "😔"
//            db.insert(word: targetWord, correct: false)
//
//            // لا يظهر زر التالي إذا كانت خطأ
//            showNextButton = false
//        }
//    }

    
    func checkWord() {
        let spoken = recognizer.transcript.trimmingCharacters(in: .whitespacesAndNewlines)

        let spokenLower = spoken.lowercased()
        let targetLower = targetWord.lowercased()

        if spokenLower.contains(targetLower) {
            resultMessage = "😁"
            db.insert(word: targetWord, correct: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showNextButton = true
            }

        } else {
            resultMessage = "😔"
            db.insert(word: targetWord, correct: false)
            showNextButton = false
        }
    }

    
    
    
    
    
    func nextSentence() {
        if currentIndex < sentences.count - 1 {
            currentIndex += 1
            recognizer.transcript = ""
            resultMessage = ""
            showNextButton = false
        } else {
            resultMessage = ""
            showNextButton = false
            confettiCounter += 1
        }
    }
}


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
 
// الموجة العلوية
struct TopWaveShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height * 0.35))
        path.addQuadCurve(
            to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.25),
            control: CGPoint(x: rect.width * -0.2, y: rect.height * 0.9)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: rect.height * 0.3),
            control: CGPoint(x: rect.width * 0.8, y: rect.height * 0.1)
        )
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.closeSubpath()
        return path
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(sentences: ["Apple", "Ant", "Air"])
    }
}



#Preview {
//    HomeView(sentences: ["Apple", "Ant", "Air"])
    HomeView(sentences: ["Up", "Air", "Arm"])

}
