import SwiftUI

struct ContentView: View {
    @State private var showSplash: Bool = true
    
    var body: some View {
        ZStack {
            if showSplash {
                // شاشة السبلاش
                SplashView(showSplash: $showSplash)
            } else {
                // شاشة الـ Onboarding الأولى
                OnboardingView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
