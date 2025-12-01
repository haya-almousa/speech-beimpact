//
//  mice.swift
//  Speech-beImpact
//
//  Created by Wed Ahmed Alasiri on 09/06/1447 AH.
//

import SwiftUI
//import ConfettiSwiftUI

struct HomeView: View {
    @StateObject var recognizer = SpeechRecognizer()
    let db = SQLiteManager()
    
    @State private var sentences = [
        "أسد",
        "أخطبوط",
        "إوزة"
    
    ]
    
    @State private var currentIndex = 0
    @State private var confettiCounter = 0
    @State private var isRecording = false
    
    var targetWord: String {
        sentences[currentIndex]
    }
    
    @State private var resultMessage = ""
    @State private var showNextButton = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            // 🔶 Top Wave Shape
            TopWaveShape()
                .fill(Color(red: 0.90, green: 0.74, blue: 0.20))
                .frame(height: 180)
                .shadow(color: .black.opacity(0.12), radius:8, y: 6)
                .ignoresSafeArea()
                .offset(y: -299)   // ← ينزل الموجة بدون ما يظهر فراغ

            
            VStack(spacing: 50) {
                Spacer().frame(height: 150)
                
                // مربع الجملة
                Text(targetWord)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 300, height: 120)
                    .background(Color(hex: "EA8A48"))
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.15), radius: 6, y: 4)
                
                // أيقونة الميكروفون (زر واحد)
//                Button(action: {
//                    toggleRecording()
//                }) {
//                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
//                        .font(.system(size: 80))
//                        .foregroundColor(Color(red: 0.98, green: 0.80, blue: 0.20))
//                        .padding()
//                        .background(Circle().fill(Color(red: 0.86, green: 0.52, blue: 0.26).opacity(0.3)))
//                        .shadow(radius: 5)
//                }
                Button(action: {
                    toggleRecording()
                }) {
                    Image(systemName: isRecording ? "mic.fill" : "mic.slash.fill")
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(hex: "EA8A48")
                                    .opacity(0.90))
                        )
                        .shadow(color: .black.opacity(0.25), radius: 8, y: 5)
                }


//
//                Text("انت قلت:")
//                Text(recognizer.transcript)
//                    .foregroundColor(.gray)
                
                // نتيجة الطفل
                Text(resultMessage)
                    .font(.largeTitle)
                
                // زر التالي يظهر بعد التقييم
                if showNextButton {
                    Button(action: {
                        nextSentence()
                    }) {
                        Text("التالي")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 195.24, height: 42.67)
                            .background(Color(hex: "F3BB34"))//19A25B
                            .cornerRadius(25)
                            .shadow(radius: 4)
                    }

                }
                
                Spacer()
            }
            
//            ConfettiCannon(trigger: $confettiCounter)
        }
    }
    
    func toggleRecording() {
        if isRecording {
            recognizer.stop()
            checkWord()
            isRecording = false
        } else {
            recognizer.start()
            resultMessage = ""
            showNextButton = false
            isRecording = true
        }
    }
    
    func checkWord() {
        let spoken = recognizer.transcript.trimmingCharacters(in: .whitespaces)
        
        if spoken.contains(targetWord) {
            resultMessage = "😁"
            db.insert(word: targetWord, correct: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showNextButton = true
            }
            
        } else {
            resultMessage = "😕"
            db.insert(word: targetWord, correct: false)
            showNextButton = true
        }
    }
    
    func nextSentence() {
        if currentIndex < sentences.count - 1 {
            currentIndex += 1
            recognizer.transcript = ""
            resultMessage = ""
            showNextButton = false
        } else {
            resultMessage = "👏 خلصت كل الجمل"
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
        HomeView()
    }
}



#Preview {
    HomeView()
}
