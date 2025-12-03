//
//  mine.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 12/06/1447 AH.
//

import SwiftUI

struct Mine: View {
    @EnvironmentObject var userProfile: UserProfile
    @State private var showContent = false
    @State private var exerciseButtonScale: CGFloat = 1.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                starsBackground
                
                VStack(spacing: 0) {
                    header
                    Spacer()
                    exercisesButton
                    Spacer().frame(height: 100)
                }
            }
            .onAppear { showContent = true }
            .navigationBarHidden(true)
        }
    }
    
    private var starsBackground: some View {
        ForEach(0..<20) { _ in
            Image(systemName: "star.fill")
                .foregroundColor(.yellow.opacity(Double.random(in: 0.2...0.5)))
                .font(.system(size: CGFloat.random(in: 10...20)))
                .position(x: CGFloat.random(in: 50...350), y: CGFloat.random(in: 100...800))
                .opacity(showContent ? 1 : 0)
        }
    }
    
    private var header: some View {
        HStack(spacing: 15) {
            profileImage
            profileName
            Spacer()
            calendarButton
        }
        .padding(.horizontal, 30)
        .padding(.top, 60)
        .scaleEffect(showContent ? 1 : 0.8)
        .opacity(showContent ? 1 : 0)
    }
    
    private var profileImage: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 100, height: 100)
                .shadow(color: Color(hex: "#F6B922").opacity(0.4), radius: 10, y: 5)
            
            Image(userProfile.profileImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 85, height: 85)
                .clipShape(Circle())
        }
    }
    
    private var profileName: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("مرحباً")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.gray)
            
            Text(userProfile.childName.isEmpty ? "صديقي" : userProfile.childName)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(Color(hex: "#F6B922"))
        }
    }
    
    private var calendarButton: some View {
        Button {} label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(LinearGradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(hex: "#F6B922").opacity(0.4), radius: 10, y: 5)
                
                VStack(spacing: 4) {
                    Image(systemName: "calendar")
                        .font(.system(size: 32, weight: .semibold))
                    Text("التقويم")
                        .font(.system(size: 11, weight: .medium))
                }
                .foregroundColor(.white)
            }
        }
    }
    
    private var exercisesButton: some View {
        NavigationLink(destination: d()) {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color(hex: "#F6B922"))
                    .frame(width: 340, height: 160)
                    .blur(radius: 15)
                    .opacity(0.4)
                    .offset(y: 10)
                
                RoundedRectangle(cornerRadius: 40)
                    .fill(LinearGradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 340, height: 160)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .fill(LinearGradient(colors: [.white.opacity(0.4), .clear], startPoint: .topLeading, endPoint: .center))
                    )
                    .shadow(color: Color(hex: "#F6B922").opacity(0.5), radius: 20, y: 10)
                
                HStack(spacing: 20) {
                    Text("التمارين")
                        .font(.system(size: 36, weight: .bold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 32, weight: .bold))
                }
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 3, y: 2)
            }
            .scaleEffect(exerciseButtonScale)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    exerciseButtonScale = 1.08
                }
            }
        }
        .scaleEffect(showContent ? 1 : 0.5)
        .opacity(showContent ? 1 : 0)
    }
}

#Preview {
    Mine()
        .environmentObject(UserProfile())
}
