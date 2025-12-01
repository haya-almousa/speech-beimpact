//
//  videopage.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 10/06/1447 AH.
//

import SwiftUI

struct VideoPage: View {
    let letters: [String]     // الحروف الخاصة بهذا الكرت
    let videoURL: String      // رابط الفيديو لهذا الكرت
    
    var body: some View {
        LetterVideoScreen(letters: letters, videoURL: videoURL)
    }
}

struct LetterVideoScreen: View {
    
    let letters: [String]
    let videoURL: String
    
    var body: some View {
        ZStack {
            
            // الخلفية الجديدة (بدون زخارف)
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                
                Spacer().frame(height: 140)   // ↓↓↓ تنزيل الحروف
                
                // الحروف (تجي من HomeScreen)
                HStack(spacing: 55) {
                    ForEach(letters, id: \.self) { letter in
                        Text(letter)
                    }
                }
                .font(.system(size: 47, weight: .medium))
                .foregroundColor(Color(red: 241/255, green: 176/255, blue: 0/255))
                
                Spacer().frame(height: 60)   // ↓↓↓ تنزيل زر الفيديو
                
                // زر الفيديو
                Button {
                    openYouTube()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.93, green: 0.55, blue: 0.16))
                            .frame(width: 300, height: 190)
                            .shadow(radius: 3)
                        
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.08))
                    }
                }
                .buttonStyle(.plain)
                
                Spacer().frame(height: 160)  // ↓↓↓ زر التالي
                
                // زر "التالي"
                Button {
                    print("التالي تم الضغط عليه")
                } label: {
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color(red: 234/255, green: 138/255, blue: 72/255))
                        .frame(width: 200, height: 45)
                }
                .buttonStyle(.plain)
                .shadow(radius: 2)
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
    
    func openYouTube() {
        if let url = URL(string: videoURL) {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    VideoPage(
        letters: ["أِ", "أُ", "أَ"],
        videoURL: "https://youtu.be/biWQsbDq5O0?feature=shared"
    )
}
