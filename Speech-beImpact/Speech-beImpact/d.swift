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
    
    // تمارين كل حرف
    let exercises: [String: [String]] = [
        "A": ["Apple", "Ant", "Air"],
        "B": ["Ball", "Bee", "Banana"],
        "C": ["Cat", "Cake", "Car"]
        // كمّلي الباقي
    ]

    // هنا نربط كل صورة كرت بالحروف + ID الفيديو حقها
    // كمّلي أنتي باقي الحروف والـ IDs
    let letterData: [String: ([String], String)] = [
        "Image 1": (["A"], "biWQsbDq5O0"),
        "Image 2": (["B"], "xxxxxxxxxxx"),
        "Image 3": (["C"], "yyyyyyyyyyy")
        // ... كمّلي للباقي Image 4 .. Image 9
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
                            if let data = letterData[imageName] {
                                // استخرج الحرف الأول لهذا الكرت ثم التمارين له
                                let lettersForCard = data.0
                                let videoID = data.1
                                let sentencesForCard: [String] = {
                                    if let firstLetter = lettersForCard.first,
                                       let tasks = exercises[firstLetter] {
                                        return tasks
                                    } else {
                                        return []
                                    }
                                }()
                                
                                NavigationLink {
                                    // نفتح صفحة الفيديو أولاً ونمرر التمارين الصحيحة معها
                                    VideoPage(
                                        letters: lettersForCard,
                                        videoID: videoID,
                                        sentences: sentencesForCard
                                    )
                                } label: {
                                    Image(imageName)
                                        .resizable()
                                        .frame(width: 269, height: 103)
                                        .clipped()
                                }
                                .buttonStyle(.plain)
                            } else {
                                Image(imageName)
                                    .resizable()
                                    .frame(width: 269, height: 103)
                                    .clipped()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center) // توسيط المحتوى
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
