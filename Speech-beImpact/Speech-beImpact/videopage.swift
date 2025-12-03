//
//  videopage.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 10/06/1447 AH.
//

//import SwiftUI
//
//struct VideoPage: View {
//    let letters: [String]     // الحروف الخاصة بهذا الكرت
//    let videoURL: String      // رابط الفيديو لهذا الكرت
//    
//    var body: some View {
//        LetterVideoScreen(letters: letters, videoURL: videoURL)
//    }
//}
//
//struct LetterVideoScreen: View {
//    
//    let letters: [String]
//    let videoURL: String
//    
//    var body: some View {
//        ZStack {
//            
//            // الخلفية الجديدة (بدون زخارف)
//            Image("خلفيتي")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//            
//            VStack {
//                
//                Spacer().frame(height: 140)   // ↓↓↓ تنزيل الحروف
//                
//                // الحروف (تجي من HomeScreen)
//                HStack(spacing: 55) {
//                    ForEach(letters, id: \.self) { letter in
//                        Text(letter)
//                    }
//                }
//                .font(.system(size: 47, weight: .medium))
//                .foregroundColor(Color(red: 241/255, green: 176/255, blue: 0/255))
//                
//                Spacer().frame(height: 60)   // ↓↓↓ تنزيل زر الفيديو
//                
//                // زر الفيديو
//                Button {
//                    openYouTube()
//                } label: {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 24)
//                            .fill(Color(red: 0.93, green: 0.55, blue: 0.16))
//                            .frame(width: 300, height: 190)
//                            .shadow(radius: 3)
//                        
//                        Image(systemName: "play.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 80, height: 80)
//                            .foregroundColor(Color(red: 1.0, green: 0.84, blue: 0.08))
//                    }
//                }
//                .buttonStyle(.plain)
//                
//                Spacer().frame(height: 160)  // ↓↓↓ زر التالي
//                
//                // زر "التالي"
//                Button {
//                    print("التالي تم الضغط عليه")
//                } label: {
//                    RoundedRectangle(cornerRadius: 21)
//                        .fill(Color(red: 234/255, green: 138/255, blue: 72/255))
//                        .frame(width: 200, height: 45)
//                }
//                .buttonStyle(.plain)
//                .shadow(radius: 2)
//                
//                Spacer()
//            }
//            .padding(.horizontal, 32)
//        }
//    }
//    
//    func openYouTube() {
//        if let url = URL(string: videoURL) {
//            UIApplication.shared.open(url)
//        }
//    }
//}
//
//#Preview {
//    VideoPage(
//        letters: ["أِ", "أُ", "أَ"],
//        videoURL: "https://youtu.be/biWQsbDq5O0?feature=shared"
//    )
//}

import SwiftUI
import WebKit

// MARK: - Video WebView
struct YouTubeVideoView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false // يمنع التمرير داخل الفيديو
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedURLString = "https://www.youtube.com/embed/\(videoID)?playsinline=1"
        if let url = URL(string: embedURLString) {
            uiView.load(URLRequest(url: url))
        }
    }
}

// MARK: - Video Page
struct VideoPage: View {
    let letters: [String]     // الحروف الخاصة بهذا الكرت
    let videoID: String       // ID الفيديو فقط

    var body: some View {
        LetterVideoScreen(letters: letters, videoID: videoID)
    }
}

// MARK: - Letter Video Screen
struct LetterVideoScreen: View {
    
    let letters: [String]
    let videoID: String
    
    var body: some View {
        ZStack {
            
            // الخلفية
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer().frame(height: 140)
                
                // الحروف
                HStack(spacing: 55) {
                    ForEach(letters, id: \.self) { letter in
                        Text(letter)
                    }
                }
                .font(.system(size: 47, weight: .medium))
                .foregroundColor(Color(red: 241/255, green: 176/255, blue: 0/255))
                
                Spacer().frame(height: 60)
                
                // الفيديو داخل التطبيق
                YouTubeVideoView(videoID: videoID)
                    .frame(width: 350, height: 190)
                    .cornerRadius(24)
                    .shadow(radius: 3)
                
                Spacer().frame(height: 160)
                
                // زر التالي
//                Button {
//                    print("التالي تم الضغط عليه")
//                } label:{
//                    RoundedRectangle(cornerRadius: 21)
//                        .fill(Color(red: 234/255, green: 138/255, blue: 72/255))
//                        .frame(width: 200, height: 45)
//                }
//                .buttonStyle(.plain)
//                .shadow(radius: 2)
                
                // زر "التالي" → يفتح صفحة HomeView
                // زر "التالي" → يفتح HomeView
                NavigationLink {
                    HomeView()
                } label: {
                    RoundedRectangle(cornerRadius: 21)
                        .fill(Color(red: 234/255, green: 138/255, blue: 72/255))
                        .frame(width: 200, height: 45)
                        .overlay(
                            Text("التالي")
                                .foregroundColor(.white)
                                .font(.title3)
                        )
                }
                .buttonStyle(.plain)
                .shadow(radius: 2)


                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

// MARK: - Preview
#Preview {
    VideoPage(
        letters: ["أِ", "أُ", "أَ"],
        videoID: "biWQsbDq5O0" // ضع هنا Video ID من رابط اليوتيوب
    )
}
