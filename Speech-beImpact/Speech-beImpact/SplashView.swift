//
//  SplashView.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 12/06/1447 AH.
//

import SwiftUI

struct SplashView: View {
    @Binding var showSplash: Bool
    
    @State private var showTopStars = false
    @State private var showTitle = false
    @State private var showBottomStars = false
    
    var body: some View {
        ZStack {
            // الخلفية
            Color(hex: "#F6B922")
                .ignoresSafeArea()
            
            VStack {
                
                // النجوم العلوية
                topStars
                    .offset(y: showTopStars ? 0 : 250)
                    .opacity(showTopStars ? 1 : 0)
                
                Spacer()
                
                // الكلمة
                Image("pronounceMeChalk")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 340)
                    .scaleEffect(showTitle ? 1 : 0.5)
                    .opacity(showTitle ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.5), value: showTitle)
                
                Spacer()
                
                // النجوم السفلية (مرفوعة فوق)
                bottomStars
                    .offset(y: showBottomStars ? -40 : 300)   // ← هنا رفعتها
                    .opacity(showBottomStars ? 1 : 0)
            }
            .padding(.vertical, 40)
        }
        .onAppear { runAnimationSequence() }
    }
    
    // MARK: - النجوم العلوية (متباعدة)
    private var topStars: some View {
        ZStack {
            Image("chalkStar")
                .resizable()
                .frame(width: 150, height: 150)
                .offset(x: -110, y: 45)
            
            Image("chalkStar")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(x: -15, y: -25)
            
            Image("chalkStar")
                .resizable()
                .frame(width: 80, height: 80)
                .offset(x: 115, y: -35)
            
            Image("chalkStar")
                .resizable()
                .frame(width: 120, height: 120)
                .offset(x: 95, y: 60)
        }
        .frame(height: 250)
    }
    
    // MARK: - النجوم السفلية (مرفوعة ومتباعدة)
    private var bottomStars: some View {
        ZStack {
            Image("chalkStar")
                .resizable()
                .frame(width: 150, height: 150)
                .offset(x: -110, y: -10)  // ↑ رفعتها
            
            Image("chalkStar")
                .resizable()
                .frame(width: 95, height: 95)
                .offset(x: -10, y: -55)   // ↑ رفعتها أكثر
            
            Image("chalkStar")
                .resizable()
                .frame(width: 130, height: 130)
                .offset(x: 110, y: -15)   // ↑ رفعتها
            
            Image("chalkStar")
                .resizable()
                .frame(width: 100, height: 100)
                .offset(x: 35, y: 40)     // ↑ رفعتها
        }
        .frame(height: 260)
    }
    
    // MARK: - الأنيميشن
    private func runAnimationSequence() {
        withAnimation(.easeOut(duration: 0.7)) {
            showTopStars = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            showTitle = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            withAnimation(.easeOut(duration: 0.7)) {
                showBottomStars = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
            withAnimation {
                showSplash = false
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(showSplash: .constant(true))
    }
}//
//  SplashView.swift
//  Speech-beImpact
//
//  Created by Yara Alsabti on 12/06/1447 AH.
//
