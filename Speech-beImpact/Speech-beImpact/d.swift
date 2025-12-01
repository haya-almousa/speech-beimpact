//
//  d.swift
//  Speech-beImpact
//
//  Created by danah alsadan on 09/06/1447 AH.
//

import SwiftUI

struct d: View {
    var body: some View {
        // لازم NavigationStack عشان التنقل للصفحة الثانية
        NavigationStack {
            HomeScreen()
        }
    }
}

struct HomeScreen: View {
    
    // أسماء صور كروت الأحرف
    let letterImages: [String] = [
        "Image 1",
        "Image 2",
        "Image 3",
        "Image 4",
        "Image 5",
        "Image 6",
        "Image 7",
        "Image 8",
        "Image 9"
    ]
    
    // هنا نربط كل صورة كرت بالحروف + رابط الفيديو حقها
    // كمّلي أنتي باقي الحروف والروابط
    let letterData: [String: ([String], String)] = [
        "Image 1": (["أِ", "أُ", "أَ"], "https://youtu.be/biWQsbDq5O0?feature=shared"),
        // "Image 2": (["بِ", "بُ", "بَ"], "رابط_الباء"),
        // "Image 3": (["تِ", "تُ", "تَ"], "رابط_التاء"),
        // ... كمّلي للباقي
    ]
    
    var body: some View {
        ZStack {

            // الخلفية الجديدة فقط (بدون زخارف)
            Image("خلفيتي")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 24) {
                
                // الأفاتار + name
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .stroke(Color(red: 0.20, green: 0.50, blue: 0.90), lineWidth: 6)
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(Color(red: 0.20, green: 0.50, blue: 0.90))
                    }
                    
                    Text("name")
                        .font(.system(size: 32, weight: .regular))
                        .foregroundColor(Color(red: 0.85, green: 0.27, blue: 0.16))
                    
                    Spacer()
                }
                .padding(.top, 40)
                
                // كروت الأحرف
                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(letterImages, id: \.self) { imageName in
                            
                            // إذا عندنا بيانات لهذا الكرت (حروف + فيديو)
                            if let data = letterData[imageName] {
                                NavigationLink {
                                    // نرسل الحروف + رابط الفيديو لصفحة الفيديو
                                    VideoPage(
                                        letters: data.0,
                                        videoURL: data.1
                                    )
                                } label: {
                                    ZStack {
                                        // صورة الكرت
                                        Image(imageName)
                                            .resizable()
                                            .frame(width: 269, height: 103)
                                            .clipped()
                                        
                                        // صورة الأسد فوق Image 1 فقط
                                        if imageName == "Image 1" {
                                            Image("أسد")
                                                .resizable()
                                                .frame(width: 60, height: 60)
                                                .offset(x: -80, y: -1)
                                        }
                                    }
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                // لو ما حطيتِ بيانات للكرت، يبان كزر عادي بدون تنقل
                                ZStack {
                                    Image(imageName)
                                        .resizable()
                                        .frame(width: 269, height: 103)
                                        .clipped()
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                    .padding(.bottom, 60)
                }
                
                Spacer()
            }
            .padding(.horizontal, 32)
        }
    }
}

#Preview {
    d()
}
