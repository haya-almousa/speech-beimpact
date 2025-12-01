import SwiftUI

struct CurvedHeader: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
        path.addQuadCurve(
            to: CGPoint(x: 0, y: rect.maxY * 0.6),
            control: CGPoint(x: rect.midX, y: rect.maxY * 1.2)
        )
        path.addLine(to: .zero)
        return path
    }
}

struct AnimalQuizView: View {
    // شرح: حالة لتتبع هل تم اختيار إجابة صحيحة (أسد) أم لا
    @State private var isCorrect = false
    // شرح: حالة لتتبع اسم الخيار الذي ضغطه المستخدم (لاستخدامها في تلوين الزر أو منع التكرار)
    @State private var selectedOption: String? = nil
    // شرح: حالة لإظهار تنبيه عند الإجابة الصحيحة (إلى أن تضعي انتقال فعلي لصفحة ثانية)
    @State private var showCorrectAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            // الخلفية العامة للتطبيق من الأصول
            Image("خلفيتي")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ادفع المحتوى للمنتصف رأسيًا
                Spacer(minLength: 0)
                
                // بطاقة المحتوى: القصة + الحروف + الصورة
                VStack(spacing: 0) {
                    // Main text
                    VStack(spacing: 0) {
                        Text("خرج احمد الى حديقة\nالحيوانات و وجد")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 22, weight: .regular))
                            .foregroundColor(.black)
                        Text("............")
                            .font(.system(size: 24, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top, 2)
                    }
                    .padding(.top, 2)
                    
                    // Animal names with colored first letters
                    HStack(spacing: 20) {
                        // جمل
                        HStack(spacing: 0) {
                            Text("مل")
                                .foregroundColor(.white)
                            Text("ج")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                        
                        // بطة
                        HStack(spacing: 0) {
                            Text("طه")
                                .foregroundColor(.white)
                            Text("ب")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                        
                        // أسد
                        HStack(spacing: 0) {
                            Text("سد")
                                .foregroundColor(.white)
                            Text("أ")
                                .foregroundColor(.black)
                        }
                        .font(.system(size: 24, weight: .regular))
                    }
                    .padding(.horizontal, 12)
                    
                    // صورة الأسد
                    Image("أسد")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding(.top, 2)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 6)
                .frame(maxWidth: 560) // زيادة الحد الأقصى للعرض
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(.gray).opacity(0.07))
                )
                // حواف بارزة (ظلال خفيفة مزدوجة لإحساس البطاقة)
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 8)
                .shadow(color: .white.opacity(0.2), radius: 2, x: -1, y: -1)
                .padding(.horizontal, 30) // تقليل الحواف الجانبية لتظهر أعرض على الشاشات الصغيرة
                
                // خيارات الإجابات جنب بعض (أفقية)
                HStack(spacing: 12) {
                    liquidGlassButton(title: "جمل") {
                        handleSelection(option: "جمل")
                    }
                    liquidGlassButton(title: "بطة") {
                        handleSelection(option: "بطة")
                    }
                    liquidGlassButton(title: "أسد") {
                        handleSelection(option: "أسد")
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal, 40)
                
                // ادفع للأسفل قليلًا لتحافظ على التمركز العام
                Spacer(minLength: 0)
            }
        }
        // نزيل تنبيه الخطأ تمامًا، ونبقي تنبيه الصح إذا رغبتِ
        .alert("أحسنت!", isPresented: $showCorrectAlert) {
            Button("متابعة") {
                // TODO: الانتقال للصفحة التالية عند الإجابة الصحيحة
            }
        } message: {
            Text("اختيار صحيح.")
        }
    }
    
    // MARK: - Actions
    private func handleSelection(option: String) {
        selectedOption = option
        if option == "أسد" {
            isCorrect = true
            showCorrectAlert = true
        } else {
            isCorrect = false
            // لا تنبيه للخطأ؛ فقط يتغير لون الخيار عبر selectedOption
        }
    }
    
    // MARK: - Components
    // زر "Liquid Glass" قابل لإعادة الاستخدام
    @ViewBuilder
    private func liquidGlassButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            let isSelected = selectedOption == title
            let isRight = title == "أسد"
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(isSelected ? (isRight ? .green : .red) : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.white.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 3)
        }
        .disabled(isCorrect && title != "أسد")
    }
}

#Preview {
    AnimalQuizView()
}
