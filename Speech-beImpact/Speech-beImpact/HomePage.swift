//
//  HomePage.swift
//  Speech-beImpact
//
//  Created by Hneen on 12/06/1447 AH.
//
import SwiftUI

struct HomePage: View {
    @EnvironmentObject var userProfile: UserProfile
    @State private var showContent = false
    @State private var exerciseButtonScale: CGFloat = 1.0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                ForEach(0..<20) { i in
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow.opacity(Double.random(in: 0.2...0.5)))
                        .font(.system(size: CGFloat.random(in: 10...20)))
                        .position(x: CGFloat.random(in: 50...350), y: CGFloat.random(in: 100...800))
                        .opacity(showContent ? 1 : 0)
                }
                
                VStack(spacing: 0) {
                    HStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 100, height: 100)
                                .shadow(color: Color(hex: "#F6B922").opacity(0.4), radius: 10, x: 0, y: 5)
                            
                            Image(userProfile.profileImageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("مرحباً")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.gray)
                            
                            Text(userProfile.childName.isEmpty ? "صديقي" : userProfile.childName)
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color(hex: "#F6B922"))
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 80, height: 80)
                                    .shadow(color: Color(hex: "#F6B922").opacity(0.4), radius: 10, x: 0, y: 5)
                                
                                VStack(spacing: 4) {
                                    Image(systemName: "calendar")
                                        .font(.system(size: 32, weight: .semibold))
                                        .foregroundColor(.white)
                                    
                                    Text("التقويم")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 60)
                    .scaleEffect(showContent ? 1 : 0.8)
                    .opacity(showContent ? 1 : 0)
                    
                    Spacer()
                    
                    NavigationLink(destination: HomeScreen()) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color(hex: "#F6B922"))
                                .frame(width: 340, height: 160)
                                .blur(radius: 15)
                                .opacity(0.4)
                                .offset(y: 10)
                            
                            RoundedRectangle(cornerRadius: 40)
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 340, height: 160)
                                .overlay(RoundedRectangle(cornerRadius: 40).fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.4), Color.clear]), startPoint: .topLeading, endPoint: .center)))
                                .shadow(color: Color(hex: "#F6B922").opacity(0.5), radius: 20, x: 0, y: 10)
                            
                            HStack(spacing: 20) {
                                Text("التمارين")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.white)
                                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 2)
                            }
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
                    
                    Spacer()
                    
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#F6B922").opacity(0.2))
                                .frame(width: 130, height: 130)
                                .blur(radius: 20)
                            
                            Circle()
                                .fill(LinearGradient(gradient: Gradient(colors: [Color(hex: "#F6B922"), Color(hex: "#F6B922").opacity(0.9)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 110, height: 110)
                                .shadow(color: Color(hex: "#F6B922").opacity(0.4), radius: 15, x: 0, y: 8)
                            
                            Image(systemName: "person.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white)
                        }
                    }
                    .scaleEffect(showContent ? 1 : 0.5)
                    .opacity(showContent ? 1 : 0)
                    .padding(.bottom, 50)
                }
            }
            .onAppear {
                showContent = true
            }
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    HomePage()
}
