import SwiftUI

private enum QuizStyle {
    static let brand = Color(.white)
    static let cardCorner: CGFloat = 20
    static let buttonCorner: CGFloat = 14
    static let contentMaxWidth: CGFloat = 560

    // عرض مرجعي للصورة (نستخدمه كعرض ثابت ثم نكبر/نصغر بالـ scale)
    static let baseImageWidth: CGFloat = 220

    // ارتفاع ثابت لمنطقة الصورة داخل الكرت (لا يتغير)
    static let imageAreaHeight: CGFloat = 240

    // ارتفاع ثابت للكرت بالكامل (لا يتغير)
    static let cardFixedHeight: CGFloat = 300
}

struct AnimalQuizView: View {
    @StateObject private var vm: AnimalQuizViewModel

    init(story: QuizStory, onCorrect: (() -> Void)? = nil) {
        _vm = StateObject(wrappedValue: AnimalQuizViewModel(story: story, onCorrect: onCorrect))
    }

    var body: some View {
        ZStack(alignment: .top) {
            background

            VStack(spacing: 0) {
                Spacer(minLength: 0)
                contentCard
                optionsRow
                Spacer(minLength: 0)
            }
        }
        .alert("Great job!", isPresented: $vm.showCorrectAlert) {
            Button("Continue", action: vm.dismissAlert)
        } message: {
            Text("Correct choice.")
        }
        .accessibilityElement(children: .contain)
    }

    // MARK: - Subviews

    private var background: some View {
        Image("خلفيتي")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }

    private var contentCard: some View {
        VStack(spacing: 0) {
            VStack(spacing: 6) {
                Text(vm.story.line)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)

                Text(vm.story.placeholder)
                    // المسافه بين القصه والفراغ
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
                    .accessibilityLabel("blank")
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)

            // منطقة ثابتة الارتفاع للصورة حتى لا يتغير حجم الكرت
            ZStack {
                Color.clear

                // نحسب scale من العرض المرغوب (إن وُجد) مقابل العرض المرجعي
                let desiredWidth = vm.story.imageSize?.width ?? QuizStyle.baseImageWidth
                let scale = max(0.01, desiredWidth / QuizStyle.baseImageWidth)

                Image(vm.story.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: QuizStyle.baseImageWidth) // إطار مرجعي ثابت
                    .scaleEffect(scale, anchor: .center)   // التكبير/التصغير هنا فقط
                    .accessibilityLabel(vm.story.imageName)
            }
            .frame(height: QuizStyle.imageAreaHeight) // ثابت
            .clipped()
            .padding(.top, 6)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .frame(maxWidth: QuizStyle.contentMaxWidth)
        .frame(height: QuizStyle.cardFixedHeight) // ثابت، يمنع تمدد الكرت
        .background(
            RoundedRectangle(cornerRadius: QuizStyle.cardCorner, style: .continuous)
                .fill(QuizStyle.brand)
        )
        .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 8)
        .shadow(color: .white.opacity(0.2), radius: 2, x: -1, y: -1)
        .padding(.horizontal, 30)
    }

    private var optionsRow: some View {
        HStack(spacing: 12) {
            ForEach(vm.story.options, id: \.self) { option in
                optionButton(option)
                    .disabled(vm.isDisabled(option))
                    .accessibilityHint("Double tap to choose \(option)")
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 40)
    }

    private func optionButton(_ title: String) -> some View {
        Button { vm.select(option: title) } label: {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(vm.foregroundColor(for: title))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: QuizStyle.buttonCorner, style: .continuous)
                        .fill(QuizStyle.brand)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: QuizStyle.buttonCorner, style: .continuous)
                        .stroke(QuizStyle.brand)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}

// MARK: - Preview
#Preview {
    AnimalQuizView(
        story: QuizStory(
            line: "Ahmed went to the zoo and found",
            imageName: "أسد",
            options: ["Crocodile", "Alligator", "Lizard"],
            correct: "Crocodile",
            // تحكم بحجم الصورة عبر هذا العرض فقط (مثلاً 180، 220، 300...)
            imageSize: .init(width: 280, height: 0)
        ),
        onCorrect: { print("Correct: Crocodile") }
    )
}
