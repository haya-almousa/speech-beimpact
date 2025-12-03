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
        // لو تبغين الـ embed الصحيح:
        // let embedURLString = "https://www.youtube.com/embed/\(videoID)?playsinline=1"
        let embedURLString = "https://www.youtube.com/watch?v=\(videoID)&playsinline=1"
        if let url = URL(string: embedURLString) {
            uiView.load(URLRequest(url: url))
        }
    }
}

// MARK: - Video Page
struct VideoPage: View {
    let letters: [String]     // الحروف الخاصة بهذا الكرت
    let videoID: String       // ID الفيديو فقط
    let sentences: [String]   // التمارين المناسبة للحرف

    var body: some View {
        LetterVideoScreen(letters: letters, videoID: videoID, sentences: sentences)
    }
}

// MARK: - Letter Video Screen
struct LetterVideoScreen: View {
    
    let letters: [String]
    let videoID: String
    let sentences: [String]   // ← تمارين الحرف

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
                
                
                // زر "التالي" → يفتح HomeView بالتمارين الصحيحة
                NavigationLink {
                            HomeView(sentences: sentences)
                        } label: {
                            Text("Start Exercises")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220)
                                .background(Color(hex: "f6b922"))
                                .cornerRadius(20)
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
        videoID: "biWQsbDq5O0",
        sentences: ["Apple","Air"]
    )
}
