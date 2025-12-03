//
//  Untitled.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 12/06/1447 AH.
//

import SwiftUI

struct OnboardingView: View {
    @State private var childName: String = ""
    @State private var selectedGender: Gender? = nil
    
    // يظهر زر Let's Practice فقط إذا الاسم مكتوب والجنس مختار
    private var canProceed: Bool {
        !childName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGender != nil
    }
    
    var body: some View {
        ZStack {
            // الخلفية بالصورة بدل الأبيض
            Image("خلفيتي")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Spacer().frame(height: 40) // مسافة بسيطة من فوق
                
                // كرت Hello + الاسم
                nameCard
                
                // I am a...
                Text("I am a…")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(hex: "#F6B922"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.top, 8)
                
                // boy / girl buttons
                HStack(spacing: 40) {
                    genderButton(type: .boy)
                    genderButton(type: .girl)
                }
                .padding(.top, 8)
                
                Spacer()
                
                // زر Let’s Practice! يظهر فقط لما الشروط تتحقق
                if canProceed {
                    Button {
                        // TODO: الانتقال للصفحة اللي بعدها
                    } label: {
                        Text("Let’s Practice!")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(hex: "#F6B922"))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                            .shadow(radius: 4, y: 3)
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                } else {
                    Spacer().frame(height: 80) // عشان ما يطلع فراغ غريب لما يختفي الزر
                }
            }
        }
    }
    
    // MARK: - كرت الاسم
    private var nameCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color(hex: "#F6B922"))
                .shadow(radius: 4, y: 3)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Hello!")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    TextField("", text: $childName)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .placeholder(when: childName.isEmpty) {
                            Text("Name")
                                .font(.system(size: 24, weight: .medium))
                                .foregroundColor(.white.opacity(0.5)) // شبه شفاف
                        }
                        .multilineTextAlignment(.leading)
                }
                
                Rectangle()
                    .fill(Color.white.opacity(0.9))
                    .frame(height: 2)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 18)
        }
        .padding(.horizontal, 32)
    }
    
    // MARK: - زر الجنس (boy / girl)
    @ViewBuilder
    private func genderButton(type: Gender) -> some View {
        let isSelected = selectedGender == type
        
        Button {
            selectedGender = type
        } label: {
            VStack(spacing: 8) {
                Image(type == .boy ? "boyCharacter" : "girlCharacter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .offset(x: type == .boy ? 6 : 0) // تمركز الولد فقط
                    .padding(10)
                    .background(
                        Circle()
                            .stroke(Color(hex: "#F6B922"), lineWidth: isSelected ? 5 : 3)
                            .background(
                                Circle()
                                    .fill(isSelected ? Color(hex: "#F6B922").opacity(0.15) : Color.clear)
                            )
                    )
                
                Text(type == .boy ? "boy" : "girl")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(
                        isSelected
                        ? Color(hex: "#F6B922")
                        : Color(hex: "#F6B922").opacity(0.7)
                    )
            }
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: selectedGender)
    }
}

// نوع الجنس
enum Gender {
    case boy
    case girl
}

// Placeholder modifier للـ TextField
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}
