//
//  videopage.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 10/06/1447 AH.
//

import SwiftUI

struct VideoPage: View {
    var body: some View {
        LetterVideoScreen()
    }
}

struct LetterVideoScreen: View {
    
    var body: some View {
        ZStack {
            // خلفية
            Color.white.ignoresSafeArea()
            
            // الزخارف الصفراء (فوق وتحت)
            VStack(spacing: 0) {
                // الزخرفة العليا
                Image("Image")
                    .resizable()
                    .frame(width: 393, height: 111)
                    .clipped()
                
                Spacer()
                
                // الزخرفة السفلى
                Image("Image 1")
                    .resizable()
                    .frame(width: 393.33, height: 42.5)
                    .clipped()
            }
            .ignoresSafeArea()
            
            // المحتوى
            VStack {
                Spacer().frame(height: 40)
                
                // الحروف الثلاثة أعلى الصفحة
                HStack(spacing: 60) {
                    Text("أِ")
                    Text("أُ")
                    Text("أَ")
                }
                .font(.system(size: 40, weight: .medium))
                .foregroundColor(Color.orange)
                
                Spacer().frame(height: 40)
                
                // مستطيل التشغيل (Play) – يفتح يوتيوب
                Button {
                    openYouTube()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.93, green: 0.55, blue: 0.16)) // برتقالي قريب من التصميم
                            .frame(width: 260, height: 170)
                            .shadow(radius: 3)
                        
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(red: 0.98, green: 0.83, blue: 0.20)) // أصفر
                    }
                }
                .buttonStyle(.plain)
                
                Spacer()
                
                // زر "التالي" بالمقاس واللون المطلوب
                Button {
                    print("التالي تم الضغط عليه")
                    // هنا بعدين تربطينه بالصفحة اللي بعدها
                } label: {
                    Text("التالي")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 195.24, height: 42.67)
                        .background(
                            RoundedRectangle(cornerRadius: 21)
                                .fill(Color(red: 234/255, green: 138/255, blue: 72/255)) // #EA8A48
                        )
                }
                .buttonStyle(.plain)
                .shadow(radius: 2)
                .padding(.bottom, 70)
            }
            .padding(.horizontal, 32)
        }
    }
    
    // فتح رابط اليوتيوب
    func openYouTube() {
        if let url = URL(string: "https://youtu.be/biWQsbDq5O0?feature=shared") {
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    VideoPage()
}
